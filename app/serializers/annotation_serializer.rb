class AnnotationSerializer < ActiveModel::Serializer
  attributes :id
  has_many :anchors
end
