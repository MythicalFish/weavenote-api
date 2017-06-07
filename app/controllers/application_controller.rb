class ApplicationController < ActionController::API
  
  include SetUser
  include ApiResponse

  def root
    render json: {}
  end

end
