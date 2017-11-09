class AddUsernameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :username, :string, required: true, unique: true
    add_index :users, :username
  end
end
