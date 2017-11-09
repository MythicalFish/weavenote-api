class Project < ApplicationRecord

  has_many :roles, as: :roleable
  has_many :direct_collaborators, source: :user, through: :roles

  belongs_to :organization
  has_many :components, dependent: :destroy
  has_many :materials, through: :components
  has_many :images, as: :imageable, dependent: :destroy
  has_many :annotations, through: :images
  has_many :measurement_groups, dependent: :destroy
  has_many :measurement_names, dependent: :destroy
  has_many :measurement_values, through: :measurement_groups
  has_many :instructions, dependent: :destroy
  has_many :invites, as: :invitable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
    
  amoeba { enable }

  validates :name, length: { minimum: 3 }
  
  scope :active, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }
  
  alias_attribute :stage, :development_stage

  def role_types
    RoleType.find([2,3]).map{ |r| r.attributes }
  end

  def project
    self # For simplifying set_project in several controllers
  end

  def primary_image
    images.where(primary: true).first || images.first
  end

  def image_url size = :large
    i = primary_image
    i.file.url(size) if i
  end

  def thumbnail_url
    image_url :tiny
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

  def collaborators
    # merge project & org collaborators
    p_ids = self.direct_collaborators.ids
    o_ids = self.organization.collaborators.ids
    ids = (p_ids + o_ids).uniq
    # return simple array of avatars & names
    ids.map do |id| 
      u = User.find(id)
      { name: u.name, avatar_src: u.avatar, display: u.name, id: u.username }
    end
  end

  private

end
