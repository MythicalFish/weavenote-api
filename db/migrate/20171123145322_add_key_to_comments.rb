class AddKeyToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :key, :string
    add_index :comments, :key, unique: true
  end
end
