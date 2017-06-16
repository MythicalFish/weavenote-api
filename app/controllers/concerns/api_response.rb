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
        trace = exception.backtrace
        backtrace = trace ? "\n\n" + trace.join("\n") : nil;
        r[:json][:server_error] = exception.message  + backtrace
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

  def validation_error data
    if data.is_a?(Object) || data.is_a?(String)
      render json: { validation_error: data.to_s }
    end
  end

end