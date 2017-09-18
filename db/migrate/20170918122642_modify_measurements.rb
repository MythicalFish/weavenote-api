class ModifyMeasurements < ActiveRecord::Migration[5.0]
  def change
    change_column :measurement_values, :value, :integer, precision: 10, null: true, default: ''
    change_column_default(:measurement_values, :value, nil)
    change_column :measurement_names, :value, :string, null: true
    change_column :measurement_groups, :name, :string, null: true
  end
end
