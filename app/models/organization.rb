class Organization < ApplicationRecord
  
  has_many :roles, as: :roleable
  has_many :collaborators, source: :user, through: :roles
  
  has_many :projects
  has_many :instructions, through: :projects
  has_many :images
  has_many :invites, as: :invitable
  has_many :suppliers
  has_many :materials

  def owner
    roles.where(role_type_id: RoleType.admin.id).first.user
  end

  def role_types
    RoleType.find([3,5]).map { |r| r.attributes }
  end

end
