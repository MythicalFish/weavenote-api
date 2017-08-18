class Role < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :role_type
  belongs_to :roleable, polymorphic: true

  alias_attribute :type, :role_type
  
  default_scope { where(role_type_id: RoleType::EXPOSED_IDS) }
  scope :permitted, -> { where(role_type_id: RoleType::PERMITTED_IDS) }

  def self.none
    self.new role_type: RoleType.none 
  end

end
