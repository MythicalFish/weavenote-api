class ProjectsController < ApplicationController

  before_action :set_project, except: [:index, :create]
  
  skip_before_action :check_ability!, only: [ :show, :update ]
  before_action :check_project_ability!, only: [ :show, :update ]

  def index
    render json: project_list, each_serializer: ProjectListSerializer
  end

  def show
    render json: {
      project: serialized(@project),
      images: serialized(@project.images),
      comments: serialized(@project.comments.order(created_at: :desc)),
      user_role: @user.project_role_type(@project).attributes,
      avatar_list: @project.avatar_list(@user)
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

  def export_to_pdf
    spec_sheet = SpecSheet.new(@project, pdf_name)
    path = spec_sheet.create_pdf
    file = File.open(path)
    storage = Fog::Storage.new( Rails.configuration.fog )
    headers = { "Content-Type" => 'application/pdf', "x-amz-acl" => "public-read" }
    s = storage.put_object(ENV['WEAVENOTE__AWS_S3_BUCKET'], pdf_name, file, headers )
    url = "https://#{s.host}#{s.path}"
    render json: { url: url }
  end

  private

  def pdf_name
    t = Time.now.strftime('%Y-%m-%d_%I-%M')
    "#{@project.name.split(' ').join('-')}__#{t}.pdf"
  end

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

  def check_project_ability!
    # Same as in check_ability.rb, however @project
    # has been set by now, so the result is different
    ability_check! action_name.to_sym
  end

  def project_params
    params.require(:project).permit(
      :name, :identifier, :archived, :images, :description,
      :development_stage_id, :category
    )
  end

end
