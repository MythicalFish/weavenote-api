class RemoveQuantityFromMaterials < ActiveRecord::Migration[5.0]
  def change
    remove_column :materials, :quantity
  end
end
