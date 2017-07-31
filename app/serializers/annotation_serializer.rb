class AnnotationSerializer < ActiveModel::Serializer
  attributes :id
  has_many :anchors
  belongs_to :annotatable, serializer: AnnotatableSerializer
end
