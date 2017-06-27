module ApiResponse
  
  extend ActiveSupport::Concern

  included do
    
    rescue_from Exception, with: :handle_exception

    def user_error object
      raise ActiveRecord::RecordInvalid.new(object)
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
    if e.class == ActiveRecord::RecordInvalid
      user_error_response e.record
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
    if data.is_a?(Hash)
      r[:json][:user_error][:message] = data[:message] if data[:message]
      r[:json][:user_error][:fields] = data[:fields] if data[:fields]
    elsif data.is_a?(String)
      r[:json][:user_error][:message] = data
    elsif data.is_a?(Object)
      r[:json][:user_error][:message] = data.errors.full_messages.join("\n")
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
      backtrace = trace ? "\n\n" + trace.join("\n") : nil;
      r[:json][:server_error] = e.message  + backtrace
    end
    render r
  end

end