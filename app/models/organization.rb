class Organization < ApplicationRecord
  
  has_many :roles
  has_many :users, through: :roles
  has_many :projects
  has_many :images
  has_many :invitations
  has_many :suppliers
  has_many :materials

end
