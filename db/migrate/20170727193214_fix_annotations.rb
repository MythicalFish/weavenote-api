class FixAnnotations < ActiveRecord::Migration[5.0]
  def change
    rename_column :annotations, :type, :annotation_type
    add_column :annotations, :annotatable_type, :string
    remove_index :annotations, :annotatable_id
    add_index :annotations, [:annotatable_id, :annotatable_type]
  end
end
