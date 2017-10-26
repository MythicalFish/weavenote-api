class Comment < ApplicationRecord
  
  belongs_to :user
  belongs_to :organization
  belongs_to :commentable, polymorphic: true
  has_many :images, as: :imageable, dependent: :destroy  
  has_many :comments, as: :commentable, dependent: :destroy
  has_one :annotation, as: :annotatable, dependent: :destroy

  validates :text, length: { minimum: 2 }

  scope :annotated, -> { joins(:annotation) }

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

end
