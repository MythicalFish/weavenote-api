class UsersController < ApiController
  
  def show
    render json: @user
  end

  def update
    @user.update!(user_params)
    render_success "Profile updated", @user
  end

  def verify_email_change
    byebug
    render_success "Please check your inbox to complete the change"
  end

  def change_email

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
  
  def get_auth0_management_token
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

    response = http.request(request)
    response.read_body
  end

end
