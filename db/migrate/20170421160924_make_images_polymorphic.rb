class MakeImagesPolymorphic < ActiveRecord::Migration[5.0]
  def change
    rename_column :images, :project_id, :imageable_id
    add_column :images, :imageable_type, :string
    add_index :images, [:imageable_id, :imageable_type]
  end
end
