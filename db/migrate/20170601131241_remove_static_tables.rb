class RemoveStaticTables < ActiveRecord::Migration[5.0]
  def change
    drop_table :material_types
    drop_table :colors
    drop_table :development_stages
    drop_table :care_labels
    drop_table :currencies
  end
end
