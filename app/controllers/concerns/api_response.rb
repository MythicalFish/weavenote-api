module ApiResponse
  
  extend ActiveSupport::Concern

  included do
    
    rescue_from Exception, with: :server_response
    rescue_from StandardError, with: :nothing

    def user_error error
      r = {
        json: {
          user_error: {
            message: "Something went wrong",
            fields: []
          }
        }
      }
      if error.is_a?(Hash)
        r[:json][:user_error][:message] = error[:message] if error[:message]
        r[:json][:user_error][:field] = error[:fields] if error[:fields]
      elsif error.is_a?(String)
        r[:json][:user_error][:message] = error
      end
      render r
      raise StandardError.new
    end

    def render_success message, payload
      render json: {
        message: message,
        payload: payload
      }
    end
    
  end

  def server_response exception
    r = {
      json: {
        server_error: "A server-side error occured."
      },
      status: :unprocessable_entity
    }
    if Rails.env.development?
      trace = exception.backtrace
      backtrace = trace ? "\n\n" + trace.join("\n") : nil;
      r[:json][:server_error] = exception.message  + backtrace
    end
    render r
  end

  def nothing
    # already rendered the response in user_error
    # this simply prevents DoubleRenderError
  end

end