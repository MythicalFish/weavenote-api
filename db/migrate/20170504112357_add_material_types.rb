class AddMaterialTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :material_types do |t|
      t.string :name, index: true, null: false
      t.integer :user_id, index: true, null: false
    end
    rename_column :materials, :type, :material_type_id
    change_column :materials, :material_type_id, :integer
  end
end
