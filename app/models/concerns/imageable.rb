module Imageable
  extend ActiveSupport::Concern
  included do

    def create_image data
      if data.try(:id)
        data.imageable_id = self.id
        data.imageable_type = self.model_name.name
        data.save!
      else
        data[:imageable_id] = self.id
        data[:imageable_type] = self.model_name.name
        self.user.images.create(data)
      end
    end

  end
end