class Role < ApplicationRecord
  belongs_to :user
  belongs_to :organization
  belongs_to :role_type
end
