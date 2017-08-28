class ComponentsController < ApplicationController

  before_action :set_project
  before_action :set_component, only: [:show, :update, :destroy]

  before_action :check_ability!

  def index
    render json: list
  end

  def show
    render json: @component
  end

  def create
    @component = @project.components.new(component_params)
    @component.save!
    render_success "Material added", serialized(list)
  end

  def update
    @component.update!(component_params)
    render_success "Material updated", serialized(list)
  end

  def destroy
    @component.destroy!
    render_success "Material deleted", list
  end

  private

  def list
    @project.components.order('id DESC')
  end

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
