class ChangeInvitations < ActiveRecord::Migration[5.0]
  def change
    add_index :roles, [:roleable_id, :roleable_type]
    remove_index :roles, :roleable_id
    remove_index :roles, :roleable_type
    rename_table :invitations, :invites
    rename_column :invites, :organization_id, :invitable_id
    add_column :invites, :invitable_type, :string, null: false
    remove_index :invites, :invitable_id
    add_index :invites, [:invitable_id, :invitable_type]
    remove_index :images, :imageable_id
    
  end
end
