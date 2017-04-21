class Project < ApplicationRecord
  belongs_to :user
  has_many :materials, through: :users
  has_many :images
  has_one :development_stage
end
