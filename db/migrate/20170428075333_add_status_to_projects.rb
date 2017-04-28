class AddStatusToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :archived, :boolean, default: false
    add_index :projects, :archived
  end
end
