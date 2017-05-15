class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy, :material_cost, :measurement_values]

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
    @project = @user.projects.new(project_params)
    if @project.save
      #render json: @project, status: :created, location: @project
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

  # GET /projects/:id/measurements
  def measurement_values
    render json: @project.measurement_values
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = @user.projects.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(
        :name, :identifier, :archived, :images, :description,
        :development_stage_id, :category
      )
    end
end
