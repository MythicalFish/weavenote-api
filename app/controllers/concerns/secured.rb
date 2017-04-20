# frozen_string_literal: true
module Secured
  extend ActiveSupport::Concern
  #require 'auth0'
  included do
    before_action :authenticate_request!
  end

  private

  def authenticate_request!
    # auth0 = Auth0Client.new(
    #   :client_id => Rails.application.secrets.auth0_client_id,
    #   :token => http_token,
    #   :domain => Rails.application.secrets.auth0_domain,
    #   :api_version => 2
    # )
    # puts auth0.inspect
    auth_token
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  def http_token
    return request.headers['Authorization']
    if request.headers['Authorization'].present?
      request.headers['Authorization'].split(' ').last
    end
  end

  def auth_token
    JsonWebToken.decode(http_token)
  end
end