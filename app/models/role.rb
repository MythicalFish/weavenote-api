class Role < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :role_type
  belongs_to :roleable, polymorphic: true

  alias_attribute :type, :role_type
  
  scope :exposed, -> { where(role_type_id: RoleType::EXPOSED_IDS) }

  def self.none
    self.new role_type: RoleType.none 
  end

  def role_type_name
    self.role_type.name
  end

end
