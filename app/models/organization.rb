class Organization < ApplicationRecord
  
  has_and_belongs_to_many :subscriptions, class_name: Payola::Subscription, join_table: 'organizations_subscriptions'
  has_many :roles, as: :roleable
  has_many :collaborators_and_guests, source: :user, through: :roles

  has_many :active_roles, -> { where({ role_type_id: RoleType::EXPOSED_IDS }) }, as: :roleable, class_name: "Role"
  has_many :collaborators, source: :user, through: :active_roles
  
  has_many :projects
  has_many :instructions, through: :projects
  has_many :images
  has_many :invites, as: :invitable
  has_many :suppliers
  has_many :materials

  def active_subscription
    subscriptions.map { |s|
      return s if s.active?
    }[0]  
  end

  def owner
    roles.where(role_type_id: RoleType.admin.id).first.user
  end

  def role_types
    RoleType.find([3,5]).map { |r| r.attributes }
  end

end
