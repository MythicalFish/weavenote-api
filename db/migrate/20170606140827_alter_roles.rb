class AlterRoles < ActiveRecord::Migration[5.0]
  def change
    rename_column :roles, :organization_id, :roleable_id
    change_column :roles, :roleable_id, :integer, null: false, polymorphic: true
    add_column :roles, :roleable_type, :string, null: false
    add_index :roles, :roleable_type
  end
end
