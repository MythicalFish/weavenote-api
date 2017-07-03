module ApiResponse
  
  extend ActiveSupport::Concern

  included do
    rescue_from Exception, with: :handle_exception
  end

  def render_success message, payload = nil
    render json: {
      message: message,
      payload: payload
    }
  end

  def render_warning message, payload = nil
    render json: {
      warning: message,
      payload: payload
    }
    raise CustomException::UserWarning.new
  end

  def render_error object
    raise CustomException::UserError.new(object)
  end

  def render_fatal data
    raise Exception.new(data)
  end

  def handle_exception e
    if e.class == CustomException::UserWarning
      # This exception is just to prevent the DoubleRenderError error
    else
      render error_response(e)
    end
  end

  def error_response e
    
    msg = "Something went wrong, we'll look into it!"
    trace = nil

    if expose_error? e
      if e.try(:errors)
        msg = e.errors.full_messages.join("\n")
      elsif e.try(:message)
        msg = e.message
      end
    end

    if e.class == Auth0::Unauthorized
      msg = "Unauthorized"
    end

    if Rails.env.development?
      if e.backtrace
        trace = "API says no: \n\n"
        trace += " " + e.message + "\n" + e.backtrace.take(10).join("\n")
        trace += "\n..." if e.backtrace.size > 10
      end
    end
    
    {
       json: {
        error: {
          message: msg,
          fields: [],
          backtrace: trace
        },
        status: :unprocessable_entity
      }
    }

  end

  def expose_error? e
    [
      CustomException::UserError, 
      CustomException::PermissionError, 
      ActiveRecord::RecordInvalid
    ].include? e.class
  end

end