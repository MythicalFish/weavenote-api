class FixMaterialAssociations2 < ActiveRecord::Migration[5.0]
  def change
    add_index :materials, :user_id
  end
end
