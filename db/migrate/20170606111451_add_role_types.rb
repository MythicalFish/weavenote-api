class AddRoleTypes < ActiveRecord::Migration[5.0]
  def change
    rename_table :organizations_users, :roles
    rename_column :roles, :role_id, :role_type_id
  end
end
