module InitializeUser
  
  extend ActiveSupport::Concern
  
  def initialize_user!
    @user = find_user
    @user = create_user unless @user
    @organization = @user.organization
  end

  def find_user
    User.find_by_auth0_id(auth0_id)
  end

  def create_user
    info = auth0.user_info
    User.create!({
      name: info['nickname'],
      email: info['email'],
      avatar: info['picture'],
      auth0_id: info['user_id']
    })
  end

  def update_avatar
    info = @auth0.user_info
    user = find_user(info['user_id'])
    user.update!(avatar: info['picture']) if user
    info
  end

end