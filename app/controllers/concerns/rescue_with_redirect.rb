module RescueWithRedirect
  
  extend ActiveSupport::Concern

  included do
    rescue_from CustomException::Redirect, with: :do_redirect
  end

  def rescue_with_redirect path
    raise CustomException::Redirect.new(path)
  end

  def do_redirect e
    redirect_to e.message 
  end

end