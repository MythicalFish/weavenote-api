class AddUserAssociationToAnnotation < ActiveRecord::Migration[5.0]
  def change
    add_column :annotations, :user_id, :integer, null: false
    add_index :annotations, :user_id
  end
end
