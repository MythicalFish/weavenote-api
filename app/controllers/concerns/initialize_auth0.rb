module InitializeAuth0
  
  extend ActiveSupport::Concern
  require 'auth0'
  AUTH0_CACHE = ActiveSupport::Cache::MemoryStore.new(expires_in: 30.minutes)
  
  def auth0_id
    AUTH0_CACHE.fetch(cache_key_for_token) do
      auth0.user_info['user_id']
    end
  end

  def auth0
    Auth0Client.new(
      :client_id => ENV['AUTH0_CLIENT_ID'],
      :domain => ENV['AUTH0_DOMAIN'],
      :token => auth0_token,
      :api_version => 2
    )
  end

  def auth0_token

    if is_api_mode?

      # Check request header for token (used for API mode).
      header = request.headers['Authorization']
      token = header.split(' ').last if header
      # Return token if found
      return token if token
      # Break if not found
      raise "No token found" unless token

    elsif is_billing_mode?

      # Check params for token
      if params[:access_token]
        # Set the cookie & remove param
        cookies[:access_token] = params[:access_token]
        rescue_with_redirect request.fullpath.split('?')[0]
      else
        # Return cookie token if present
        return cookies[:access_token] if cookies[:access_token]
        # Go back to main app if no token in billing mode.
        rescue_with_redirect ENV['WEAVENOTE__SITE_URL']
      end
    else
      raise "Neither API nor Billing mode"
    end
  end

  def cache_key_for_token
    "user_info_from_token___#{auth0_token}"
  end  


end