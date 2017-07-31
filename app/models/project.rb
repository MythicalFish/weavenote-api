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
