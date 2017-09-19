class ModifyMeasurements < ActiveRecord::Migration[5.0]
  def up
    change_column_null(:measurement_values, :value, true)
    change_column_default(:measurement_values, :value, nil)
    change_column :measurement_values, :value, :string
    change_column_null(:measurement_names, :value, true)
    change_column_null(:measurement_groups, :name, true)
  end
  def down
    change_column :measurement_values, :value, :integer, precision: 10
    change_column_null(:measurement_values, :value, false, 0)
    change_column_null(:measurement_names, :value, false, 0)
    change_column_null(:measurement_groups, :name, false, 0)
  end
end
