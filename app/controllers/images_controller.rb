class ImagesController < ApplicationController

  include Serializer
  before_action :set_imageable, except: [:s3_url]

  def index
    render json: images_response
  end

  def create
    @image = @imageable.images.create!(image_params)
    attach_image! @image.url
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
    path = "seamless/uploads/unmodified/#{@user.email}/#{Time.now.to_i}__#{params[:objectName]}"
    
    url = storage.put_object_url('content.mythical.fish', path, 3.minutes.from_now.to_time.to_i, headers, options)
    
    render json: { 
      signedUrl: url,
      url: url.split('?')[0]
    }

  end

  private

  def attach_image! url
    extname = File.extname(url)
    basename = File.basename(url, extname)
    newfile = Tempfile.new([basename, extname])
    newfile.binmode
    open(URI.parse(url)) do |data|  
      newfile.write data.read
    end
    newfile.rewind
    @image.update!(file:newfile)
  end

  def image_params
    p = params[:image]
    p[:organization_id] = @organization.id
    p[:user_id] = @user.id
    p.permit(:url, :name, :organization_id, :user_id)
  end

  def set_imageable
    imageable_class = Object.const_get(params[:imageable][:type])
    collection = imageable_class.model_name.collection
    @imageable = @organization.send(collection).find(params[:imageable][:id])
    raise "Missing imageable" unless @imageable
  end

  def images_response
    images = serialized(@imageable.images.order('id ASC'))
    return { images: images, imageable_type: @imageable.model_name }
  end

end
