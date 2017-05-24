class AddMissingAttributesToMaterials < ActiveRecord::Migration[5.0]
  def change
    add_column :materials, :subtype, :string
    rename_column :suppliers, :name_ref, :ref
    add_index :suppliers, :user_id
    add_index :suppliers, :name
  end
end
