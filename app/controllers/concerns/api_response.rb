module ApiResponse
  
  extend ActiveSupport::Concern

  included do
    
    rescue_from Exception, with: :handle_exception

    def user_error object
      raise StandardError.new(object)
    end

    def server_error data
      raise Exception.new(data)
    end

    def render_success message, payload
      render json: {
        message: message,
        payload: payload
      }
    end

  end

  def handle_exception e
    if [StandardError, ActiveRecord::RecordInvalid].include? e.class
      user_error_response e
    else
      server_error_response e
    end
  end

  def user_error_response data
    r = {
      json: {
        user_error: {
          message: "Something went wrong",
          fields: []
        },
      status: :unprocessable_entity
      }
    }
    if data.try(:errors)
      r[:json][:user_error][:message] = data.errors.full_messages.join("\n")
    elsif data.try(:message)
      r[:json][:user_error][:message] = data.message
    end
    render r
  end

  def server_error_response e
    r = {
      json: {
        server_error: "A server-side error occured."
      },
      status: :unprocessable_entity
    }
    if Rails.env.development?
      trace = e.backtrace
      backtrace = trace ? "\n" + trace.take(5).join("\n") : nil;
      backtrace += "\n..." if trace && trace.size > 5
      r[:json][:server_error] = e.message  + backtrace
    end
    render r
  end

end