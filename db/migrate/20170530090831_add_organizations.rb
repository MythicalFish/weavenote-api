class AddOrganizations < ActiveRecord::Migration[5.0]
  def change
    
    create_table :organizations do |t|
      t.string :name, null: false, index: true
    end

    add_column :projects, :organization_id, :integer, null: false
    remove_column :projects, :user_id
    
    create_join_table :organizations, :users do |t|
      t.index :organization_id
      t.index :user_id
      t.integer :role_id, null: false, index: true
    end
    
    rename_column :images, :user_id, :organization_id

    create_table :invitations do |t|
      t.string :email, null: false, index: true
      t.integer :organization_id, null: false, index: true
      t.string :key, null: false, index: true
      t.boolean :accepted, default: false, null: false, index: true
    end

  end
end
