class RolesController < ApplicationController

  include ::Invitable
  before_action :set_invitable
  before_action :set_role, only: [:update, :destroy]

  def index
    render json: roles
  end

  def update
    @role.update!(role_params)
    render_success "Role updated", roles
  end
  
  def destroy
    @role.destroy!
    @collaborator.update!(current_organization_id: 0) if @invitable.class.name == 'Organization'
    render_success "Collaborator removed from #{@invitable.class.name}", roles
  end

  private

  def roles
    @invitable.roles.where(role_type_id:RoleType::EXPOSED_IDS)
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

end
