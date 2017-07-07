class ProjectsController < ApplicationController

  before_action :set_project, except: [:index, :create]
  before_action :set_permission, except: [:index, :create]

  def index
    archived = params[:archived] == "true" ? true : false
    @projects = @user.projects
      .order('created_at DESC')
      .where(archived: archived)
    render json: @projects
  end

  def show
    render json: {
      attributes: @project.serialized,
      user_role: @user.project_role_type(@project),
      material_cost: @project.material_cost,
      collaborators: @project.collaborators,
    }
  end

  def create
    @project = @organization.projects.new(project_params)
    @project.save!
    index
  end

  def update
    @project.update!(project_params)
    if params[:index_after_update]
      index
    else 
      render json: @project
    end
  end

  def destroy
    @project.destroy!
  end

  def material_cost
    render json: @project.material_cost
  end

  private

  def set_project
    id = params[:project_id] || params[:id]
    @project = @user.projects.find(id)
  end

  def set_permission
    return unless @project
    @ability = Ability.new(@user, @project)
  end

  def project_params
    params.require(:project).permit(
      :name, :identifier, :archived, :images, :description,
      :development_stage_id, :category
    )
  end

end
