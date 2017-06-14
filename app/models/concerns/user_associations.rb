module UserAssociations
  extend ActiveSupport::Concern
  included do
      
    has_many :roles

    has_many :organization_roles, -> (o) {
      where('roleable_type = "Organization"')
    }, class_name: 'Role'

    has_many :organizations, through: :roles, source: :roleable, source_type: 'Organization'

    has_many :project_roles, -> (o) {
      where('roleable_type = "Project"')
    }, class_name: 'Role'

    has_many :assigned_projects, -> (o) {
      where('organization_id = ?', o.current_organization_id)
    }, through: :roles, source: :roleable, source_type: 'Project' 

    alias_method :orgs, :organizations
    alias_method :org_roles, :organization_roles

    def organization=(org)
      self.current_organization_id = org.id
    end
    
    def organization
      oid = self.current_organization_id
      org = self.orgs.find_by_id(oid) if oid
      unless org
        org = self.orgs.first
        self.update(organization: org) if org
      end
      return org
    end

    alias_method :org, :organization

    def organization_role
      org_roles.find_by_roleable_id org.id
    end
    
    alias_method :org_role, :organization_role
    
    def project_role project
      role = project_roles.find_by_roleable_id(project.id)
      return role if role
      organization_role
    end

    def projects
      if ['Admin', 'Manager'].include? org_role.type.name
        return org.projects
      else
        return assigned_projects
      end
    end

  end
end