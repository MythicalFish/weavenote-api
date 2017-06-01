module Imageable
  extend ActiveSupport::Concern
  included do

    def create_image data
      if data.try(:id)
        # Image exists
        data.imageable_id = self.id
        data.imageable_type = self.model_name.name
        data.save!
      else
        # New image
        data[:imageable_id] = self.id
        data[:imageable_type] = self.model_name.name
        self.organization.images.create(data)
      end
    end

  end
end