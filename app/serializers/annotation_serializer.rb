class AnnotationSerializer < ActiveModel::Serializer
  attributes :id, :type, :user_id
  has_many :anchors
  belongs_to :annotatable, serializer: AnnotatableSerializer
end
