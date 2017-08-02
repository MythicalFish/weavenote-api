class AnnotationSerializer < ActiveModel::Serializer
  attributes :id, :type
  has_many :anchors
  belongs_to :annotatable, serializer: AnnotatableSerializer
end
