class ApplicationController < ActionController::API
  
  include ApiResponse
  include Serializer

  include InitializeAuth0
  include InitializeUser
  include CheckAbility

  before_action :initialize_user!
  before_action :check_ability!

  def root
    render json: {}
  end

end
