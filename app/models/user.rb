class User < ApplicationRecord
  
  has_and_belongs_to_many :organizations
  has_many :projects, through: :organizations

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
