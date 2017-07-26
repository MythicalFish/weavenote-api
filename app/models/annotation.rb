class Annotation < ApplicationRecord
  belongs_to :image
  belongs_to :annotatable, polymorphic: true
end