module SetUser
  
  extend ActiveSupport::Concern
  
  require 'auth0'

  CACHE = ActiveSupport::Cache::MemoryStore.new(expires_in: 30.minutes) # this caches in Development too

  def set_user!
    @user = User.find_by_auth0_id(auth0_id)
    unless @user
      @user = User.create({
        name: user_info['nickname'],
        email: user_info['email'],
        avatar: user_info['picture'],
        auth0_id: auth0_id
      })
    end
    @organization = @user.organization
  end

  def auth0_id
    CACHE.fetch(cache_key_for_auth0_id) do
      user_info['user_id']
    end
  end

  def user_info
    secrets = Rails.application.secrets
    auth0 = Auth0Client.new(
      :client_id => secrets.auth0_client_id,
      :token => token,
      :domain => secrets.auth0_domain,
      :api_version => 2
    )
    auth0.user_info
  end

  def token
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    raise "No token found" unless token
    token
  end

  def cache_key_for_auth0_id
    "auth0_id_from_token___#{token}"
  end

end