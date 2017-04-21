class FixMaterialAssociations < ActiveRecord::Migration[5.0]
  def change
    rename_column :materials, :project_id, :user_id
    change_column :materials, :user_id, :integer, null: false, index: true
    create_table :materials_projects do |t|
      t.belongs_to :materials, index: true
      t.belongs_to :projects, index: true
    end
  end
end
