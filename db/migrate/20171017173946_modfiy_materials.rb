class ModfiyMaterials < ActiveRecord::Migration[5.0]
  def change
    rename_column :materials, :identifier, :reference
    change_column :materials, :reference, :string, null: true
  end
end
