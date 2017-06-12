class Organization < ApplicationRecord
  
  has_many :roles, as: :roleable
  has_many :users, through: :roles
  
  has_many :projects
  has_many :collaborators, through: :projects, source: :users
  has_many :images
  has_many :invites, as: :invitable
  has_many :suppliers
  has_many :materials

end
