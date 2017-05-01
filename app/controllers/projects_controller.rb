class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy, :get_upload_url]

  # GET /projects
  def index
    archived = params[:archived] == "true" ? true : false
    @projects = @user.projects
      .order('created_at DESC')
      .where(archived: archived)
    render json: @projects
  end

  # GET /projects/1
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

  # PATCH/PUT /projects/1
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

  # DELETE /projects/1
  def destroy
    @project.destroy
  end


  # GET /projects/1/get_upload_url
  def get_upload_url

    storage = Fog::Storage.new( Rails.configuration.fog )
    options = { path_style: true }
    headers = { "Content-Type" => params[:contentType], "x-amz-acl" => "public-read" }
    
    url = storage.put_object_url('content.mythical.fish', "seamless/projects/#{@project.id}/#{params[:objectName]}", 15.minutes.from_now.to_time.to_i, headers, options)
    
    render json: { signedUrl: url }

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = @user.projects.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(:name, :identifier, :archived, :images, :development_stage_id, :category)
    end
end
