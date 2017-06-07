class User < ApplicationRecord
  
  has_many :roles
  has_many :projects, through: :roles, source: :roleable, source_type: 'Project'
  has_many :organizations, through: :roles, source: :roleable, source_type: 'Organization'

  def current_organization
    oid = self.current_organization_id
    org = self.organizations.find_by_id(oid) if oid
    unless org
      org = self.organizations.first
      self.update(current_organization_id: org.id) if org
    end
    return org
  end

  def current_organization=(org)
    self.current_organization_id = org.id
  end

  private


end
