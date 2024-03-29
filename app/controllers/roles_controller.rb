class RolesController < ApiController

  include ::Invitable
  before_action :set_invitable
  before_action :set_project
  before_action :set_role, only: [:update, :destroy]
  before_action :check_ability!

  def index
    render json: roles
  end

  def update
    @role.update!(role_params)
    render_success "Role updated", roles
  end
  
  def destroy
    fail_if_own_role
    if @invitable.class.name == 'Organization'
      # Destroy all roles related to Organization
      @role.user.roles.where({roleable_id: @organization.projects.ids, roleable_type: 'Project'}).destroy_all
    end
    @role.destroy!
    org_role = @role.user.role_for(@organization)
    if org_role.role_type_name == 'None' && @role.user.projects.length == 0
      # Destroy org role if type is "None" and has no assigned projects
      org_role.destroy!
    end
    render_success "Collaborator removed from #{@invitable.class.name}", roles
  end

  private

  def set_project
    @project = @invitable.try(:project)
  end

  def roles
    serialized(@invitable.roles.exposed)
  end

  def set_role
    @role = @invitable.roles.find(params[:id])
    @collaborator = @role.user
  end

  def role_params
    p = params[:role]
    unless RoleType::EXPOSED_IDS.include? p[:role_type_id]
      render_fatal "User attempted to assign unpermitted role_type_id"
    end
    p.permit(:role_type_id)
  end

  def fail_if_own_role
    if @role.user == @user
      render_denied "You cannot remove yourself"
    end
  end

end
