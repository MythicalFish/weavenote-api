class ApplicationController < ActionController::API
  
  include ApiResponse
  include Serializer

  include InitializeAuth0
  include InitializeUser
  include CheckAbility

  before_action :initialize_client!

  def initialize_client!
    initialize_user!
    check_ability!
  end

  def root
    render json: {}
  end

end
