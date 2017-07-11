module UserRoles
  extend ActiveSupport::Concern
  included do

    has_many :roles

    has_many :organization_roles, -> (o) {
      where('roleable_type = "Organization"')
    }, class_name: 'Role'

    def role_for roleable
      return self.roles.new(role_type:RoleType.none) unless roleable
      roleable.roles.find_by_user_id(self.id)
    end

    def role_type_for roleable
      r = role_for(roleable)
      return r.type.attributes if r
    end

    def organization_role
      unless organization
        return self.roles.new(role_type: RoleType.none)
      end
      organization_roles.find_by_roleable_id(organization.id)
    end

    def organization_role_type
      organization_role.type.attributes
    end

    def project_role project
      r = project_roles.find_by_roleable_id(project.id)
      return r if r
      organization_role
    end

    def project_role_type project
      project_role(project).type.attributes
    end

    def is_admin?
      organization_role_type.type == RoleType.admin
    end

  end
end