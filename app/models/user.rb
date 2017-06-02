class User < ApplicationRecord
  
  has_and_belongs_to_many :organizations
  has_many :projects, through: :organizations

  def current_organization
    oid = self.current_organization_id
    unless oid
      oid = self.organizations.first.try(:id)
      self.update(current_organization_id: oid) if oid
    end
    return self.organizations.find_by_id(oid) if oid
  end

  private


end
