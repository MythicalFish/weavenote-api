class ImagesController < ApplicationController

  before_action :set_imageable, except: [:s3_url]

  def index
    render json: images_response
  end

  def create
    @image = @imageable.images.create!(image_params)
    @image.save!
    render_success "Image uploaded", images_response
  end

  def destroy
    @image = @imageable.images.find(params[:id])
    @image.destroy!
    render_success "Image deleted", images_response
  end

  def s3_url

    storage = Fog::Storage.new( Rails.configuration.fog )
    options = { path_style: true }
    headers = { "Content-Type" => params[:contentType], "x-amz-acl" => "public-read" }
    path = "seamless/user_uploads/#{@user.email}/#{Time.now.to_i}__#{params[:objectName]}"
    
    url = storage.put_object_url('content.mythical.fish', path, 3.minutes.from_now.to_time.to_i, headers, options)
    
    render json: { 
      signedUrl: url,
      url: url.split('?')[0]
    }

  end

  private

  def image_params
    p = params[:image]
    p[:organization_id] = @organization.id
    p.permit(:url, :name, :organization_id)
  end

  def set_imageable
    imageable_class = Object.const_get(params[:imageable][:type])
    collection = imageable_class.model_name.collection
    @imageable = @organization.send(collection).find(params[:imageable][:id])
    raise "Missing imageable" unless @imageable
  end

  def images_response
    images = @imageable.images.order('id ASC')
    return { images: images, imageable: @imageable }
  end

end
