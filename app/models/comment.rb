class Comment < ApplicationRecord
  
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :replies, -> (o) {
      where('commentable_id = ? AND commentable_type = ?', o.id, 'Comment')
    }, class_name: 'Comment'
  has_many :images, as: :imageable  
  delegate :organization, to: :user

end
