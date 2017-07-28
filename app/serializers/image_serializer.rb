class ImageSerializer < ActiveModel::Serializer
  attributes :id, :name, :urls
  has_many :annotations, serializer: AnnotationSerializer
end
