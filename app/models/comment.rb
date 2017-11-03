class Comment < ApplicationRecord
  
  belongs_to :user
  belongs_to :organization
  belongs_to :commentable, polymorphic: true
  has_many :images, as: :imageable, dependent: :destroy  
  has_many :comments, as: :commentable, dependent: :destroy
  has_one :annotation, as: :annotatable, dependent: :destroy

  validates :text, length: { minimum: 2 }

  scope :active, -> { where(archived: false)} 
  scope :archived, -> { where(archived: true)} 
  scope :annotated, -> { joins(:annotation) }

  after_update :update_annotation

  def project
    c = commentable
    return c if c.class.name == 'Project'
  end

  def replies
    self.comments.order(created_at: :asc)
  end

  def is_reply
    self.commentable_type == 'Comment'
  end

  def type
    self.class.name
  end

  def identifier
    rid = 1
    self.commentable.comments.each do |c|
      return rid if c.id == self.id
      rid += 1
    end
  end

  def archived
    attributes['archived'] || is_reply && commentable.attributes['archived']
  end

  private

  def update_annotation
    return unless annotation.present?
    return unless changed_attributes.include? :archived
    annotation.update!(archived: archived)
  end

end
