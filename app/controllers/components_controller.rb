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
    new_components = params[:ids].map { |id| {material_id: id} }
    @project.components.create!(new_components)
    render_success "Material added", serialized(list)
  end

  def update
    @component.update!(component_params)
    render_success "Material updated", serialized(list)
  end

  def destroy
    @component.destroy!
    render_success "Material deleted", serialized(list)
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
