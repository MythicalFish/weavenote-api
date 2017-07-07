class Image < ApplicationRecord
  
  belongs_to :organization
  belongs_to :imageable, polymorphic: true

  has_attached_file :file,
    :storage => :fog,
    :fog_directory => ENV['SEAMLESS__AWS_S3_BUCKET'],
    :path => "seamless/uploads/:organization_id/:id/:style/:basename.:extension",
    #:url => "seamless/uploads/:organization_id/:id/:style/:basename.:extension",
    #:fog_host => "#{ENV['SEAMLESS__CDN']}",
    :styles => {
      :tiny =>     { :format => 'jpg', :time => 10, :geometry => "100x100#" },
      :small =>    { :format => 'jpg', :time => 10, :geometry => "300x300#"  },
      :medium =>   { :format => 'jpg', :time => 10, :geometry => "800x800>"  },
      :large =>    { :format => 'jpg', :time => 10, :geometry => "1200x1200>"  }
    },
    :default_style => :medium,
    convert_options: { all: '-strip -auto-orient -colorspace sRGB' }

  validates_attachment :file, content_type: { content_type: /\Aimage\/.*\Z/ }  

end
