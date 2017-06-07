class Role < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :role_type
  belongs_to :roleable, polymorphic: true
  
end
