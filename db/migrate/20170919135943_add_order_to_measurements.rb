class AddOrderToMeasurements < ActiveRecord::Migration[5.0]
  def change
    add_column :measurement_names, :order, :integer
    add_index :measurement_names, :order
    add_column :measurement_groups, :order, :integer
    add_index :measurement_groups, :order
  end
end
