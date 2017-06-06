class User < ApplicationRecord
  
  has_many :project_roles
  has_many :organization_roles
  has_many :projects, through: :project_roles
  has_many :organizations, through: :organization_roles

  def current_organization
    oid = self.current_organization_id
    org = self.organizations.find_by_id(oid) if oid
    unless org
      org = self.organizations.first
      self.update(current_organization_id: org.id) if org
    end
    return org
  end

  private


end
