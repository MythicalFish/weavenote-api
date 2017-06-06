class ProjectRole < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :role_type
end
