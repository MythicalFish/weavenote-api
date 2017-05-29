class User < ApplicationRecord
  has_many :projects
  has_many :material_types
  has_many :materials
  has_many :suppliers
  has_many :images
end
