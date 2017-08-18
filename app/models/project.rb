class Project < ApplicationRecord

  has_many :roles, as: :roleable
  has_many :collaborators, source: :user, through: :roles

  belongs_to :organization
  belongs_to :development_stage
  alias_attribute :stage, :development_stage
  has_many :components, dependent: :destroy
  has_many :materials, through: :components
  has_many :images, as: :imageable, dependent: :destroy
  has_many :measurement_groups, dependent: :destroy
  has_many :measurement_names, dependent: :destroy
  has_many :measurement_values, through: :measurement_groups
  has_many :instructions, dependent: :destroy
  has_many :invites, as: :invitable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  
  before_validation :set_defaults

  validates :name, length: { minimum: 3 }

  scope :active, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }

  def thumbnail_url
    i = images.order('id DESC').first
    i.file.url(:tiny) if i
  end

  def material_cost
    cost = 0.00
    components.each do |c|
      cost += c.material_cost
    end
    cost.round(2)
  end

  def measurement_values! 
    a = []
    measurement_groups.each do |group|
      measurement_names.each do |name|
        attributes = { measurement_name_id: name.id, measurement_group_id: group.id }
        value = measurement_values.where(attributes).last
        a << (value || measurement_values.new(attributes))
      end
    end
    a
  end

  def avatar_list current_user
    # merge project & org collaborators
    p_ids = self.collaborators.ids
    o_ids = self.organization.collaborators.ids
    ids = (p_ids + o_ids).uniq
    # exclude current user
    c = ids.find_index(current_user.id)
    ids.delete_at(c)
    # return simple array of avatars & names
    ids.map do |id| 
      u = User.find(id)
      { user_id: u.id, user_name: u.name, url: u.avatar }
    end
    u = User.find(1)
    r = []
    10.times do |i|
      r << { user_id: u.id, user_name: u.name, url: u.avatar }
    end
    r
  end

  private

  def set_defaults
    if self.identifier.blank?
      self.identifier = rand(36**4).to_s(36).upcase
    end
    if self.development_stage_id.blank?
      self.development_stage_id = DevelopmentStage.first.id
    end
  end

end
