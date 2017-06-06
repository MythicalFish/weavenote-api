module ToHash
  extend ActiveSupport::Concern
  included do

    def self.to_hash
      h = []
      self.all.each do |t|
        h << t.attributes
      end
      h
    end

  end
end