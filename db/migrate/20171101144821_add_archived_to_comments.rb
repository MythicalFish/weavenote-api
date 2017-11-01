class AddArchivedToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :archived, :boolean, default: false
    add_index :comments, :archived
    add_column :annotations, :archived, :boolean, default: false
    add_index :annotations, :archived
  end
end
