class User < ApplicationRecord
  
  has_many :roles
  
  has_many :organization_roles, -> (o) {
    where('roleable_type = "Organization"')
  }, class_name: 'Role'

  has_many :project_roles, -> (o) {
    where('roleable_type = "Project"')
  }, class_name: 'Role'

  has_many :organizations, through: :roles, source: :roleable, source_type: 'Organization'

  has_many :assigned_projects, -> (o) {
    where('organization_id = ?', o.current_organization_id)
  }, through: :roles, source: :roleable, source_type: 'Project' 
 
   def owned_projects
 
   end
# 
#   def projects
#     if role.type === RoleType.admin
#       return organization.projects
#     end
#   end
# 
#   def role
#     org = self.organization
#     return nil unless org
#     self.roles.where(organization_id: org.id).first
#   end
# 
#   def organization
#     oid = self.current_organization_id
#     org = self.organizations.find_by_id(oid) if oid
#     unless org
#       org = self.organizations.first
#       self.update(organization: org) if org
#     end
#     return org
#   end
# 
#   def organization=(org)
#     self.current_organization_id = org.id
#   end
# 
#   private
# 
# 
end