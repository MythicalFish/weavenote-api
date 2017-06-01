class Organization < ApplicationRecord
  
  has_and_belongs_to_many :users
  has_many :projects
  has_many :images
  has_many :invitations
  
end
