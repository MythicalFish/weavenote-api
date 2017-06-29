class ApplicationController < ActionController::API
  
  include SetUser
  include CheckAbility
  include ApiResponse

  def root
    render json: {}
  end

end
