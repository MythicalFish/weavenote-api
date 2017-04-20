class ApplicationController < ActionController::API
  
  include FindUser

  def root
    render json: {}
  end

end
