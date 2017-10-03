class ImageSerializer < ActiveModel::Serializer
  attributes :id, :name, :urls, :imageable_info
end
