class ApplicationController < ActionController::API
  
  include Secured

  def root
    render json: {}
  end

end
