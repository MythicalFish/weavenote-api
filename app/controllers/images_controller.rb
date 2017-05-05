class ImagesController < ApplicationController
  
  before_action :set_project
  before_action :set_image, only: [:show, :update, :destroy]

  # GET /projects/:project_id/images
  def index
    @images = @project.images.order('id DESC')
    render json: @images
  end

  # GET /projects/:project_id/images/:id
  def show
    render json: @image
  end

  # POST /projects/:project_id/images
  def create
    @image = @project.images.new(image_params)
    if @image.save
      render json: @image, status: :created
    else
      render json: @image.errors.full_messages.join(', '), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/:project_id/images/:id
  def update
    if @image.update(image_params)
      if params[:index_after_update]
        index
      else 
        render json: @image
      end
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/:project_id/images/:id
  def destroy
    @image.destroy
  end

  # GET /projects/:project_id/images/get_upload_url
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

  private

  def set_project
    @project = @user.projects.find(params[:project_id])
  end

  def set_image
    @image = @project.images.find(params[:id])
  end

  def image_params
    params.require(:image).permit(:url)
  end

end
