module RenderRedirect
  
  extend ActiveSupport::Concern

  included do
    rescue_from Exception, with: :handle_exception
  end

  def render_redirect path
    raise CustomException::RenderRedirect.new(path)
  end

  def handle_exception e
    if e.class.name == "CustomException::RenderRedirect"
      redirect_to e.message 
    end
  end

end