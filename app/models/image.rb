class Image < ApplicationRecord
  belongs_to :organization
  belongs_to :imageable, polymorphic: true
end
