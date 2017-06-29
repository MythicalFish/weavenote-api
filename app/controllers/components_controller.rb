class ComponentsController < ApplicationController
  
  before_action :set_project
  before_action :set_component, only: [:show, :update, :destroy]

  def index
    @components = @project.components.order('id DESC')
    render json: @components
  end

  def show
    render json: @component
  end

  def create
    @component = @project.components.new(component_params)
    @component.save!
    render json: @component
  end

  def update
    @component.update!(component_params)
    render json: @component
  end

  def destroy
    @component.destroy!
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
    params.require(:component).permit(:quantity, :material_id)
  end

end
