module RoleMethods
  extend ActiveSupport::Concern
  included do

    def role_for roleable
      return Role.none unless roleable
      role = roleable.roles.find_by_user_id(self.id)
      return role ? role : Role.none
    end

    def role_type_for roleable
      role_for(roleable).type.attributes
    end

    def organization_role
      return Role.none unless organization
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