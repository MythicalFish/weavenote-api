class Annotation < ApplicationRecord
  belongs_to :image
  belongs_to :annotatable, polymorphic: true
  has_many :anchors, class_name: 'AnnotationAnchor', dependent: :destroy
  accepts_nested_attributes_for :anchors
end