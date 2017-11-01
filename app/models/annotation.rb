class Annotation < ApplicationRecord

  belongs_to :user
  belongs_to :image
  belongs_to :annotatable, polymorphic: true, optional: true, dependent: :destroy
  has_many :anchors, class_name: 'AnnotationAnchor', dependent: :destroy
  accepts_nested_attributes_for :anchors
  alias_attribute :type, :annotation_type

  scope :active, -> { where(archived: false)} 
  scope :archived, -> { where(archived: true)} 

end