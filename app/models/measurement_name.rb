class MeasurementName < ApplicationRecord
  
  belongs_to :project
  delegate :organization, to: :project
  has_many :measurement_values, dependent: :delete_all
  has_many :annotations, as: :annotatable

  before_create :put_last

  default_scope { order(order: :asc) }

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

  private

  def put_last
    self.order = self.project.measurement_names.length + 1
  end

end
