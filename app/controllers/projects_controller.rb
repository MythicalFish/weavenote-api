class ProjectsController < ApplicationController

  before_action :set_project, except: [:index, :create]
  
  before_action :check_ability!

  def index
    render json: project_list, each_serializer: ProjectListSerializer
  end

  def show
    render json: {
      project: serialized(@project),
      images: serialized(@project.images),
      annotations: serialized(@project.annotations),
      comments: serialized(@project.comments.order(created_at: :desc)),
      user_role: @user.project_role_type(@project).name,
      abilities: Ability.new(@user, @project).list,
      avatar_list: @project.avatar_list(@user)
    }
  end

  def create
    @project = @organization.projects.new(project_params)
    @project.save!
    index
  end

  def update
    @project.update!(project_params)
    index
  end

  def destroy
    @project.destroy!
    index
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

  def project_params
    params.require(:project).permit(
      :name, :ref_number, :archived, :images, :notes,
      :development_stage, :collection, :color_code, :target_fob
    )
  end

end
