class UsersController < ApiController
  
  def show
    render json: @user
  end

  def update
    @user.update!(user_params)
    render_success "Profile updated", @user
  end

  def change_email
    # Note: not doing any kind of email address validation
    # at the moment, just straight up changing it in Auth0
    # and in the DB.
    perform_email_change params[:email]
    render_success "Email address changed"
  end

  def reset_password
    p = auth0.change_password @user.email, nil
    if p
      render_success p
    else
      render_fatal "Something went wrong, unable to reset password"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username)
  end
  
  def perform_email_change new_email
    changed = false
    old_email = @user.email
    begin
      auth0_change_email(new_email)
      changed = true
    rescue
      render_warning "Unable to change email address, it might already exist"
    end
    if changed
      begin
        @user.update!(email: new_email)
      rescue
        auth0_change_email(old_email)
        render_warning "Unable to change email address, it might already exist"
      end
    end
  end
  
  def auth0_change_email new_email
    auth0_management_client.patch_user( @user.auth0_id, { email: new_email } )
  end

  def auth0_management_client
    Auth0Client.new(
      :client_id => ENV['AUTH0_CLIENT_ID'],
      :domain => ENV['AUTH0_DOMAIN'],
      :token => get_auth0_management_token,
      :api_version => 2
    )
  end
  
  def get_auth0_management_token
    # Get a management token, as described here:
    # https://auth0.com/docs/api/management/v2/tokens#1-get-a-token
    # Required for updating a user.
    # Requires Auth0 API to be hooked up to the Auth0 Client (app)
    url = URI("https://#{ENV['AUTH0_DOMAIN']}/oauth/token")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/json'
    request.body = "{
      \"grant_type\": \"client_credentials\",
      \"client_id\": \"#{ENV['AUTH0_CLIENT_ID']}\",
      \"client_secret\": \"#{ENV['AUTH0_CLIENT_SECRET']}\",
      \"audience\": \"#{ENV['AUTH0_AUDIENCE']}\"
    }"

    response = http.request(request).read_body
    JSON.parse(response)['access_token']
  end

end
