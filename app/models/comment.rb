class Comment < ApplicationRecord
  
  belongs_to :user
  belongs_to :organization
  belongs_to :commentable, polymorphic: true
  has_many :images, as: :imageable, dependent: :destroy  
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :annotations, as: :annotatable, dependent: :destroy

  validates :text, length: { minimum: 2 }

  def replies
    self.comments.order(created_at: :asc)
  end

  def is_reply
    self.commentable_type == 'Comment'
  end

  def type
    self.class.name
  end

  def relative_id
    rid = 1
    self.commentable.comments.each do |c|
      return rid if c.id == self.id
      rid += 1
    end
  end

end
