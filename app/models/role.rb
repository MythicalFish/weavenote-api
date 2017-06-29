class Role < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :role_type
  belongs_to :roleable, polymorphic: true

  alias_attribute :type, :role_type

  def self.none
    self.new role_type: RoleType.none 
  end
  
end
