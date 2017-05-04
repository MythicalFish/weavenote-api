class Component < ApplicationRecord
  belongs_to :project
  has_one :material
end
