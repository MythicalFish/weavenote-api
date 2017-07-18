class Comment < ApplicationRecord
  
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :images, as: :imageable  
  delegate :organization, to: :user
  has_many :comments, as: :commentable
  alias_attribute :replies, :comments

  validates :text, length: { minimum: 2 }

end
