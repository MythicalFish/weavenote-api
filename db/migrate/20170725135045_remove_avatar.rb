class RemoveAvatar < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :avatar
  end
end
