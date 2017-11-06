module RoleMethods
  extend ActiveSupport::Concern
  included do

    def role_for roleable
      return nil unless roleable
      roleable.roles.find_by_user_id(self.id)
    end

    def role_type_for roleable
      r = role_for(roleable)
      return r.type if r
    end

    def organization_role
      return nil unless organization
      organization_roles.find_by_roleable_id(organization.id)
    end

    def organization_role_type
      r = organization_role
      return r.type if r
    end

    def role
      organization_role_type.try(:name)
    end

    def project_role project
      r = project_roles.find_by_roleable_id(project.id)
      return r if r
      organization_role
    end

    def project_role_type project
      project_role(project).type
    end

    def is_admin?
      organization_role_type == RoleType.admin
    end

    def is_member?
      organization_role_type == RoleType.member
    end

  end
end