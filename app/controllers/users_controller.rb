class UsersController < ApplicationController
  
  require 'uri'
  require 'net/http'
  
  def show
    render json: @user
  end

  def self.show() show end

  def update
    @user.update!(user_params)
    render_success "Profile updated", @user
  end

  def reset_password
    secrets = Rails.application.secrets
    url = URI("https://#{secrets.auth0_domain}/dbconnections/change_password")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/json'
    request.body = "{\"client_id\": \"#{secrets.auth0_client_id}\",\"email\": \"#{@user.email}\",\"connection\": \"Username-Password-Authentication\"}"
    response = http.request(request)
    if response.code == "200"
      render_success "Please check your email to reset your password"
    else
      render_fatal "Something went wrong, unable to reset password"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
