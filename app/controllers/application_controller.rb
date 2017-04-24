class ApplicationController < ActionController::API
  
  include SetUser

  def root
    render json: {}
  end

end
