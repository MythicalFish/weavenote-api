class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy, :get_upload_url, :create_image]

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


  # GET /projects/:id/get_upload_url
  def get_upload_url

    storage = Fog::Storage.new( Rails.configuration.fog )
    options = { path_style: true }
    headers = { "Content-Type" => params[:contentType], "x-amz-acl" => "public-read" }
    path = "seamless/projects/#{@project.id}/#{params[:objectName]}"
    
    url = storage.put_object_url('content.mythical.fish', path, 15.minutes.from_now.to_time.to_i, headers, options)
    
    render json: { 
      signedUrl: url,
      imageURL: url.split('?')[0],
      projectID: @project.id
    }

  end

  # POST /projects/:id/create_image
  def create_image
    image = @project.images.create(url:params['url'])
    render json: {
      image: image
    }
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
