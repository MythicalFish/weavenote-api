class AddOtherToMaterials < ActiveRecord::Migration[5.0]
  def change
    add_column :materials, :other, :string
  end
end
