class AddPrimaryToImages < ActiveRecord::Migration[5.0]
  def change
    add_column :images, :primary, :boolean, default: false
    add_index :images, :primary
  end
end
