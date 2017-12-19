class Annotation < ApplicationRecord

  belongs_to :user
  belongs_to :image
  belongs_to :annotatable, polymorphic: true, optional: true, dependent: :destroy
  has_many :anchors, class_name: 'AnnotationAnchor', dependent: :destroy
  accepts_nested_attributes_for :anchors
  alias_attribute :type, :annotation_type

  scope :active, -> { where(archived: false)} 
  scope :archived, -> { where(archived: true)} 
  scope :for_measurements, -> { where(annotation_type: ['line']) }

  after_update :update_annotatable

  def line_points
    a1 = anchors[0]
    a2 = anchors[1]
    return nil unless a1 && a2
    return [a1.x_percent, a1.y_percent, a2.x_percent, a2.y_percent].map { |a|
      "#{a}%"
    }
  end

  def midpoint
    x = 0
    y = 0
    anchors.each do |a|
      x += a.x_percent
      y += a.y_percent
    end
    { x: "#{x/2}%", y: "#{y/2}%" }
  end

  private

  def update_annotatable
    return unless annotatable.present?
    return unless changed_attributes.include? :archived
    annotatable.update!(archived: archived)
  end

end