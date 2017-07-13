class ApplicationController < ActionController::API
  
  include ApiResponse
  include SetUser
  include CheckAbility
  include Serializer

  before_action :initialize_user!

  def initialize_user!
    set_user!
    check_ability!
  end

  def root
    render json: {}
  end

end
