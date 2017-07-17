class ProjectsController < ApplicationController

  before_action :set_project, except: [:index, :create]
  before_action :set_permission, except: [:index, :create]

  def index
    render json: project_list, each_serializer: ProjectListSerializer
  end

  def show
    render json: {
      project: serialized(@project),
      user_role: @user.project_role_type(@project).attributes,
    }
  end

  def create
    @project = @organization.projects.new(project_params)
    @project.save!
    render_success "Project created", serialized(project_list)
  end

  def update
    @project.update!(project_params)
    if params[:index_after_update]
      render_success "Project archived", serialized(project_list)
    else 
      render_success "Project updated", serialized(@project)
    end
  end

  def destroy
    @project.destroy!
    render_success "Project deleted", nil
  end

  def material_cost
    render json: @project.material_cost
  end

  private

  def project_list
    archived = params[:archived] == "true" ? true : false
    @user.projects
      .order('created_at DESC')
      .where(archived: archived)
  end

  def set_project
    id = params[:project_id] || params[:id]
    @project = @user.projects.find(id)
  end

  def set_permission
    @ability = Ability.new(@user, @project)
  end

  def project_params
    params.require(:project).permit(
      :name, :identifier, :archived, :images, :description,
      :development_stage_id, :category
    )
  end

end
