class ImageSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :cropped
end
