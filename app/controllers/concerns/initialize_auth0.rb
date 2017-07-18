module InitializeAuth0
  
  extend ActiveSupport::Concern
  require 'auth0'
  AUTH0_CACHE = ActiveSupport::Cache::MemoryStore.new(expires_in: 30.minutes)

  def initialize_auth0!
    @auth0 = auth0_client
  end
  
  def auth0_client 
    AUTH0_CACHE.fetch(cache_key_for_token) do
      secrets = Rails.application.secrets
      Auth0Client.new(
        :client_id => secrets.auth0_client_id,
        :token => token,
        :domain => secrets.auth0_domain,
        :api_version => 2
      )
    end
  end

  def token
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    raise "No token found" unless token
    token
  end

  def cache_key_for_token
    "user_info_from_token___#{token}"
  end  

end