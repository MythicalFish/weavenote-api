class User < ApplicationRecord

  include UserAssociations
  include RoleMethods
  
  validates_uniqueness_of :email

  def projects
    unless organization_role_type.name == 'None'
      return organization.projects
    else
      return assigned_projects
    end
  end

  def abilities
    abilities = Ability.new(self,organization)
    abilities.list
  end

end