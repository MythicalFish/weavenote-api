class User < ApplicationRecord

  include UserAssociations
  include RoleMethods

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