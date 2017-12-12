class AnnotationSerializer < ActiveModel::Serializer
  attributes :id, :type, :user_id, :image_id, :label
  has_many :anchors
  belongs_to :annotatable, serializer: AnnotatableSerializer
end
