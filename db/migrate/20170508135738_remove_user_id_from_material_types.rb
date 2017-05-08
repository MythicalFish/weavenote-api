class RemoveUserIdFromMaterialTypes < ActiveRecord::Migration[5.0]
  def change
    remove_column :material_types, :user_id
  end
end
