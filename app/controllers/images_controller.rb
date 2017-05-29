class ImagesController < ApplicationController

  # GET /images/s3_url
  def s3_url

    storage = Fog::Storage.new( Rails.configuration.fog )
    options = { path_style: true }
    headers = { "Content-Type" => params[:contentType], "x-amz-acl" => "public-read" }
    path = "seamless/user_uploads/#{@user.email}/#{Time.now.to_i}__#{params[:objectName]}"
    
    url = storage.put_object_url('content.mythical.fish', path, 3.minutes.from_now.to_time.to_i, headers, options)
    
    render json: { 
      signedUrl: url,
      image: { url: url.split('?')[0] }
    }

  end

  private

end
