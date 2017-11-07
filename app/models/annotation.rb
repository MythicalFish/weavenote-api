class Annotation < ApplicationRecord

  belongs_to :user
  belongs_to :image
  belongs_to :annotatable, polymorphic: true, optional: true, dependent: :destroy
  has_many :anchors, class_name: 'AnnotationAnchor', dependent: :destroy
  accepts_nested_attributes_for :anchors
  alias_attribute :type, :annotation_type

  scope :active, -> { where(archived: false)} 
  scope :archived, -> { where(archived: true)} 

  after_update :update_annotatable

  def line_css
    return nil unless anchors.size > 1
    a1 = anchors[0]
    a2 = anchors[1]
    create_line a1.x_percent, a1.y_percent, a2.x_percent, a2.y_percent
  end

  private

  def update_annotatable
    return unless annotatable.present?
    return unless changed_attributes.include? :archived
    annotatable.update!(archived: archived)
  end

  def create_line x1, y1, x2, y2 
    length = Math.sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2))
    angle  = Math.atan2(y2 - y1, x2 - x1) * 180 / Math::PI
    "left: #{x1}%; top: #{y1}%; width: #{length}%; -webkit-transform: rotate(#{angle}deg);"
  end

end