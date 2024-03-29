class ProjectsController < ApiController

  before_action :set_project, except: [:index, :create]
  
  before_action :check_ability!

  def index
    archived = params[:archived] == 'true'
    render_project_list archived
  end

  def show
    render json: {
      project: serialized(@project),
      images: serialized(@project.images),
      annotations: serialized(@project.annotations.active),
      user_role: @user.project_role_type(@project).attributes,
      abilities: Ability.new(@user, @project).list,
      material_cost: get_material_cost
    }
  end

  def create
    @project = @organization.projects.new(project_params)
    @project.save!
    index
  end

  def update
    @project.update!(project_params)
  end

  def destroy
    @project.destroy!
    render_project_list
  end

  def duplicate
    p = @project.amoeba_dup
    p.name = "Duplicate of #{@project.name}"
    p.save!
    index
  end

  def categorize
    archived = params[:archived] || false
    @project.update!(archived:archived)
    render_project_list !archived
  end

  def material_cost
    render json: { cost: get_material_cost }
  end

  private

  def render_project_list archived = false
    list = @user.projects.where(archived:archived)
    render json: list, each_serializer: ProjectListSerializer
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

  def selected_currency
    Currency.find(params[:currency] || 1)
  end

  def get_material_cost
    @project.material_cost_in(selected_currency.iso_code)
  end

end
