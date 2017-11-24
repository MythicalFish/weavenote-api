class AddArchivedToMaterials < ActiveRecord::Migration[5.0]
  def change
    add_column :materials, :archived, :boolean, default: false
    add_index :materials, :archived
  end
end
