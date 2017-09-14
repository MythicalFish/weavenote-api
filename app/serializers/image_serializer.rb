class ImageSerializer < ActiveModel::Serializer
  attributes :id, :name, :urls, :imageable_info
  has_many :annotations, serializer: AnnotationSerializer
end
