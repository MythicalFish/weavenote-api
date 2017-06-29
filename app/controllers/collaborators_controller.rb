class CollaboratorsController < ApplicationController

  include SetInvitable
  before_action :set_invitable
  before_action :set_role, only: [:update, :destroy]

  def index
    render json: collaborators
  end

  def update
    @role.update!(role_type_id: collaborator_params[:role_type_id])
    render_success "Collaborator role updated", collaborators
  end
  
  def destroy
    user_can? :destroy
    @role.destroy!
    render_success "Collaborator removed from #{@invitable.class.name}", collaborators
  end

  private

  def set_role
    collaborator = @invitable.collaborators.find(params[:id])
    @role = collaborator.role_for(@invitable)
  end

  def collaborators
    @invitable.collaborators
  end

  def collaborator_params
    p = params[:collaborator]
    unless RoleType::EXPOSED_IDS.include? p[:role_type_id]
      render_fatal "User attempted to assign unpermitted role_type_id"
    end
    p.permit(:role_type_id)
  end

end
