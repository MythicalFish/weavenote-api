class FixOrgsUsersJoinTable < ActiveRecord::Migration[5.0]
  def change
    change_column :organizations_users, :role_id, :integer, index: true, default: 1
  end
end
