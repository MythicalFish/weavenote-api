class ComponentsController < ApplicationController
  
  before_action :set_project
  before_action :set_component, only: [:show, :update, :destroy]

  # GET /projects/:project_id/components
  def index
    @components = @project.components.order('id DESC')
    render json: @components
  end

  # GET /projects/:project_id/components/:id
  def show
    render json: @component
  end

  # POST /projects/:project_id/components
  def create
    @component = @project.components.new(component_params)
    if @component.save
      render json: @component, status: :created
    else
      render json: @component.errors.full_messages.join(', '), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/:project_id/components/:id
  def update
    if @component.update(component_params)
      if params[:index_after_update]
        index
      else 
        render json: @component
      end
    else
      render json: @component.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/:project_id/components/:id
  def destroy
    @component.destroy
    index
  end

  private

  def set_project
    @project = @user.projects.find(params[:project_id])
  end

  def set_component
    @component = @project.components.find(params[:id])
  end

  def component_params
    params.require(:component).permit(:quantity)
  end

end
