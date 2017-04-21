class AddAttributesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :auth0_id, :string, null: false, unique: true
    add_index :users, :auth0_id
    add_column :users, :avatar, :string
  end
end
