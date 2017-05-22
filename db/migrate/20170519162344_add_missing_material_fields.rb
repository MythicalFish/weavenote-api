class AddMissingMaterialFields < ActiveRecord::Migration[5.0]
  def change
    
    create_table :currencies do |t|
      t.string :name, null: false
      t.string :iso_code, null: false
      t.string :unicode, null: false
    end
    
    create_table :suppliers do |t|
      t.string :name, null: false  
      t.string :agent
      t.string :name_ref
      t.string :color_ref
      t.integer :minimum_order
      t.string :comments
    end

    create_table :care_labels do |t|
      t.string :label, null: false
      t.string :icon
    end

    create_table :care_labels_materials do |t|
      t.references :care_label
      t.references :material
    end

    add_column :materials, :currency_id, :integer, null: false, index: true
    add_column :materials, :supplier_id, :integer, index: true
    remove_column :materials, :price, :decimal
    add_column :materials, :cost_base, :decimal, precision: 10, scale: 2, default: 0, index: true
    add_column :materials, :cost_delivery, :decimal, precision: 10, scale: 2, default: 0
    add_column :materials, :cost_extra1, :decimal, precision: 10, scale: 2, default: 0
    add_column :materials, :cost_extra2, :decimal, precision: 10, scale: 2, default: 0
    add_column :materials, :composition, :string
    add_column :materials, :size, :string
    add_column :materials, :length, :string
    add_column :materials, :opening_type, :string

  end
end
