class AssociateImagesWithUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :images, :user_id, :integer, null: false, index: true
  end
end
