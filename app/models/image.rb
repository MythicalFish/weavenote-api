class Image < ApplicationRecord
  
  belongs_to :organization
  belongs_to :user
  belongs_to :imageable, polymorphic: true
  has_many :annotations, dependent: :destroy
  
  default_scope { order(primary: :desc)}

  has_attached_file :file,
    :path => "weavenote/uploads/organization-:organization_id/image-:id/:style/:basename.:extension",
    :storage => :fog,
    :fog_credentials =>  Rails.application.config.fog,
    :fog_directory => ENV['WEAVENOTE__AWS_S3_BUCKET'],
    :fog_host => "https://s3-#{ENV['WEAVENOTE__AWS_REGION']}.amazonaws.com/#{ENV['WEAVENOTE__AWS_S3_BUCKET']}",
    :styles => {
      :tiny =>     { :format => 'jpg', :time => 10, :geometry => "100x100#" },
      :small =>   { :format => 'jpg', :time => 10, :geometry => "400x400>"  },
      :medium =>   { :format => 'jpg', :time => 10, :geometry => "800x800>"  },
      :large =>    { :format => 'jpg', :time => 10, :geometry => "1200x1200>"  }
    },
    :default_style => :medium,
    convert_options: { all: '-strip -auto-orient -colorspace sRGB' }

  validates_attachment :file, content_type: { content_type: /\Aimage\/.*\Z/ }
  
  Paperclip.interpolates :organization_id do |attachment, style|
    attachment.instance.organization_id
  end

  def urls
    {
      tiny: file.url(:tiny),
      small: file.url(:small),
      medium: file.url(:medium),
      large: file.url(:large),
    }
  end

  private

end
