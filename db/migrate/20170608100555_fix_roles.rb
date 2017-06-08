class FixRoles < ActiveRecord::Migration[5.0]
  def change
    add_column :roles, :id, :primary_key
  end
end
