class Role < ApplicationRecord

  belongs_to :user
  belongs_to :role_type
  belongs_to :roleable, polymorphic: true
  
end
