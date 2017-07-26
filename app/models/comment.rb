class Comment < ApplicationRecord
  
  belongs_to :user
  belongs_to :organization
  belongs_to :commentable, polymorphic: true
  has_many :images, as: :imageable  
  has_many :comments, as: :commentable
  has_many :annotations, as: :annotatable
  alias_attribute :replies, :comments

  validates :text, length: { minimum: 2 }

  def is_reply
    self.commentable_type == 'Comment'
  end

end
