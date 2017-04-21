class Project < ApplicationRecord
  belongs_to :user
  has_many :materials, through: :users
  has_many :images, as: :imageable
  has_one :development_stage
  accept_nested_attributes_for :images
end
