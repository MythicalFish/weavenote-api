class AddComponents < ActiveRecord::Migration[5.0]
  def change
    create_table :components do |t|
      t.integer :project_id, index: true, null: false
      t.integer :material_id, index: true, null: false
      t.integer :quantity  
    end
    drop_table :materials_projects
  end
end
