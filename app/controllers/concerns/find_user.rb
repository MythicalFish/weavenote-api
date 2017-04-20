# frozen_string_literal: true
module FindUser
  
  extend ActiveSupport::Concern
  
  require 'auth0'

  included do
    before_action :find_user!
  end

  private

  def find_user!

    auth0 = Auth0Client.new(
      :client_id => Rails.application.secrets.auth0_client_id,
      :token => http_token,
      :domain => Rails.application.secrets.auth0_domain,
      :api_version => 2
    )

    user_info = auth0.user_info
    user = User.find_by_email(user_info['email'])

    unless user
      user = User.create({
        name: user_info['name'],
        email: user_info['email']
      })
    end

    user
    
  rescue
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  def http_token
    if request.headers['Authorization'].present?
      request.headers['Authorization'].split(' ').last
    end
  end

  def auth_token
    JsonWebToken.decode(http_token)
  end
end