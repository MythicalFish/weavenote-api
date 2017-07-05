class User < ApplicationRecord

  include UserAssociations
  include UserRoles

  def projects
    if ['Admin', 'Manager'].include? organization_role.type.name
      return organization.projects
    else
      return assigned_projects
    end
  end

  def abilities
    abilities = Ability.new(self,organization)
    abilities.list
  end

  def serialized
    ActiveModel::SerializableResource.new(self).serializable_hash
  end

end