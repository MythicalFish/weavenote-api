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

  # GET /projects/:id
  def show
    render json: @project
  end

  # POST /projects
  def create
    @project = @organization.projects.new(project_params)
    if @project.save
      index
    else
      render json: @project.errors.full_messages.join(', '), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/:id
  def update
    if @project.update(project_params)
      if params[:index_after_update]
        index
      else 
        render json: @project
      end
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/:id
  def destroy
    @project.destroy
  end

  # GET /projects/:id/material_cost
  def material_cost
    render json: @project.material_cost
  end

  # GET /projects/:project_id/images
  def images
    @images = @project.images.order('id DESC')
    render json: @images
  end

  # POST /projects/:project_id/images
  def create_image
    @image = @project.create_image(image_params)
    if @image.save
      render json: @image, status: :created
    else
      render json: @image.errors.full_messages.join(', '), status: :unprocessable_entity
    end
  end

  # DELETE /projects/:project_id/images/:id
  def destroy_image
    @image = @project.images.find(params[:id])
    @image.destroy
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
