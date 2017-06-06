class CreateProjectRoles < ActiveRecord::Migration[5.0]
  def change
    rename_column :roles, :organization_id, :project_id
    rename_table :roles, :project_roles
    create_table :organization_roles do |t|
      t.integer :user_id, null: false, index: true
      t.integer :organization_id, null: false, index: true
      t.integer :role_type_id, null: false, index: true
    end
  end
end
