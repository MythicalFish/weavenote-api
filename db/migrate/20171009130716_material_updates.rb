class MaterialUpdates < ActiveRecord::Migration[5.0]
  def change
    remove_column :materials, :color_id
    add_column :materials, :color, :string
    add_column :materials, :yarn_count, :string
    add_column :materials, :weight, :string
    add_column :materials, :width, :string
    add_column :materials, :unit_type_id, :integer
    add_index :materials, :unit_type_id

    add_column :suppliers, :email, :string
    add_column :suppliers, :country_of_origin, :string
  end
end
