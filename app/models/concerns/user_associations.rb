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

    def organization=(org)
      self.current_organization_id = org.id
    end
    
    def organization
      oid = current_organization_id
      org = organizations.find_by_id(oid) if oid
      unless org
        org = organizations.first
        self.update(organization: org) if org
        self.update(current_organization_id: 0) unless org
      end
      return org
    end

  end
end