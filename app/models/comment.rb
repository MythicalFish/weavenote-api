class Comment < ApplicationRecord
  
  belongs_to :project, dependent: :destroy
  belongs_to :user, dependent: :destroy
  has_many :images, as: :imageable  

end
