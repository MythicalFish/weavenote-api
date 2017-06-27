class Organization < ApplicationRecord
  
  has_many :roles, as: :roleable
  has_many :collaborators, source: :user, through: :roles
  
  has_many :projects
  has_many :images
  has_many :invites, as: :invitable
  has_many :suppliers
  has_many :materials

end
