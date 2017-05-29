module Imageable
  extend ActiveSupport::Concern
  included do
      
    before_action :set_resource, only: [:images, :create_image, :destroy_image]

    def images
      @images = @project.images.order('id DESC')
      render json: @images
    end

    def create_image
      @image = @project.create_image(image_params)
      if @image.save
        render json: @image, status: :created
      else
        render json: @image.errors.full_messages.join(', '), status: :unprocessable_entity
      end
    end

    def destroy_image
      @image = @project.images.find(params[:id])
      @image.destroy
      render json: @project.images
    end

    private

    def set_resource
      byebug
      # if params[:project_id] && params[:instruction_id]
      #   
      #   @resource = @user.projects.find(params[:project_id])
      # elsif params[:instruction_id]
      #   @resource = @user.projects.find(params[:project_id])
    end

    def image_params
      params.require(:image).permit(:url, :name)
    end

  end
end
  