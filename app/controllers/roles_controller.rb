class RolesController < ApplicationController

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
    @role.destroy!
    @collaborator.update!(current_organization_id: 0) if @invitable.class.name == 'Organization'
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
    unless RoleType::PERMITTED_IDS.include? p[:role_type_id]
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
