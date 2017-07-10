module Serializer
  extend ActiveSupport::Concern
    
  def serialized object
    ActiveModel::SerializableResource.new(object).serializable_hash
  end

end