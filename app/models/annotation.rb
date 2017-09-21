class Annotation < ApplicationRecord
  belongs_to :user
  belongs_to :image
  belongs_to :annotatable, polymorphic: true, optional: true
  has_many :anchors, class_name: 'AnnotationAnchor', dependent: :destroy
  accepts_nested_attributes_for :anchors
  alias_attribute :type, :annotation_type
end