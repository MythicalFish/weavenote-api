module ApiResponse
  extend ActiveSupport::Concern
  included do

    rescue_from Exception, with: :server_response

    def server_response exception
      r = {
        json: {
          server_error: "Something went wrong"
        },
        status: :unprocessable_entity
      }
      if Rails.env.development?
        backtrace = exception.backtrace.join("\n")
        r[:json][:server_error] = exception.message + "\n\n" + backtrace
      end
      render r
    end

    def validation_response data
      render({
        json: {
          error: {
            validation: {
              message: user_error(data),
              fields: error_fields(data)
            }
          }
        }
      })
    end

  end

  def user_error data
    if data.is_a?(Object) || data.is_a?(String)
      return data.to_s
    elsif data.is_a? Hash
      u = data[:user]
      return u[:message] if u
    end
  end

  def error_fields data
    return [] unless data.is_a? Hash
    u = data[:user]
    return u[:fields] if u
  end

end