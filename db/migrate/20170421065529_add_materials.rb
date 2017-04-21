class AddMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :materials do |t|
      t.string :type, null: false
      t.string :name, null: false
      t.string :identifier, null: false
      t.integer :price
      t.integer :quantity
      t.string :color
      t.references :project, null: false
      t.timestamps
    end
    add_index :materials, :type
    add_index :materials, :name
    add_index :materials, :identifier
    add_index :materials, :price
    add_index :materials, :quantity
    add_index :materials, :color
  end
end
