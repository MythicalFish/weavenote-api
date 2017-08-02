class MeasurementName < ApplicationRecord
  
  belongs_to :project
  delegate :organization, to: :project
  has_many :measurement_values, dependent: :destroy
  has_many :annotations, as: :annotatable
  validates :value, length: { minimum: 1, maximum: 16 }

  default_scope { order(value: :asc) }

  def type
    self.class.name
  end

  def identifier
    alph = ("A".."Z").to_a
    alph[relative_id-1]
  end

  def relative_id
    rid = 1
    project.measurement_names.each do |n|
      return rid if n.id == id
      rid += 1
    end
  end

end
