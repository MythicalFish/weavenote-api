class DropRoleTypes < ActiveRecord::Migration[5.0]
  def up
    drop_table :role_types
  end
end
