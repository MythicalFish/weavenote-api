class ImagesController < ApplicationController

  before_action :set_imageable
  before_action :set_image, only: [:destroy, :update]
  before_action :check_ability!

  def create
    if @imageable
      if multiple_images?
        @imageable.images.create!(create_image_params)
      else
        @imageable.image = Image.create!(create_image_params)
      end
    else
      @image = Image.create!(create_image_params)
    end
    render_success "Image uploaded", images_response
  end

  def destroy
    @image.destroy!
    render_success "Image deleted", images_response
  end

  def update
    @image.update!(update_image_params)
    render json: images_response
  end

  def s3_url

    storage = Fog::Storage.new( Rails.configuration.fog )
    options = { path_style: true }
    headers = { "Content-Type" => params[:contentType], "x-amz-acl" => "public-read" }
    path = "weavenote/uploads/unmodified/#{@user.email}/#{Time.now.to_i}__#{params[:objectName]}"
    
    url = storage.put_object_url('content.mythical.fish', path, 3.minutes.from_now.to_time.to_i, headers, options)
    
    render json: { 
      signedUrl: url,
      url: url.split('?')[0]
    }
    
  end
  
  private
  
  def create_image_params
    p = params[:image]
    p[:organization_id] = @organization.id
    p[:user_id] = @user.id
    p.permit(:url, :name, :organization_id, :user_id)
  end
  
  def update_image_params
    params.require(:image).permit(:name, :primary)
  end
  
  def images_response
    if @imageable
      r = { imageable: { id: @imageable.id, type: @imageable.class.name } }
      if multiple_images?
        r[:images] = serialized(@imageable.images.order('id ASC'))
      else
        r[:image] = serialized(@imageable.image)
      end
      return r
    elsif @image
      return { image: serialized(@image), imageable: {} }
    end
  end
  
  def set_image
    if multiple_images?
      @image = @imageable.images.find(params[:id])
    else 
      @image = @imageable.image
    end
  end

  def set_imageable
    p = params[:imageable]
    return unless p && p[:id]
    klass = Object.const_get(p[:type])
    @imageable = klass.find(p[:id])
    raise "Imageable not found" unless @imageable
    unless @imageable.organization == @organization
      raise "Imageable organization does not match the user's organization"
    end
  end

  def multiple_images?
    return false unless @imageable
    !!@imageable.try(:images)
  end

end
