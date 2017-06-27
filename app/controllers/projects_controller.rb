class ProjectsController < ApplicationController

  before_action :set_project, except: [:index, :create]

  # GET /projects
  def index
    archived = params[:archived] == "true" ? true : false
    @projects = @user.projects
      .order('created_at DESC')
      .where(archived: archived)
    render json: @projects
  end

  def show
    render json: {
      attributes: @project,
      user_role: @user.project_role(@project).type.attributes,
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

  def images
    @images = @project.images.order('id DESC')
    render json: @images
  end

  def create_image
    @image = @project.create_image(image_params)
    @image.save!
    render json: @image, status: :created
  end

  def destroy_image
    @image = @project.images.find(params[:id])
    @image.destroy!
    render json: @project.images
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    id = params[:project_id] || params[:id]
    @project = @user.projects.find(id)
  end

  # Only allow a trusted parameter "white list" through.
  def project_params
    params.require(:project).permit(
      :name, :identifier, :archived, :images, :description,
      :development_stage_id, :category
    )
  end

  def image_params
    params.require(:image).permit(:url, :name)
  end

end
