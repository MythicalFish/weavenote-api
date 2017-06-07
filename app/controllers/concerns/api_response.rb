module ApiResponse
  extend ActiveSupport::Concern
  included do

    def error_response data
      {
        json: {
          error: {
            message: error_message(data),
            fields: error_fields(data)
          }
        },
        status: :unprocessable_entity
      }
    end

    def error_message data
      if data.is_a?(Object) || data.is_a?(String)
        return data.to_s
      elsif data.is_a? Hash
        return data[:message].to_s
      end
    end

    def error_fields data
      return [] unless data.is_a? Hash
      return data[:fields]
    end

  end
end