class AddMeasurements < ActiveRecord::Migration[5.0]
  def change

    create_table :measurement_groups do |t|
      t.string :name, null: false
      t.integer :project_id, null: false, index: true
    end
    
    create_table :measurement_names do |t|
      t.string :value, null: false, index: true
      t.integer :project_id, null: false, index: true
      t.timestamps
    end

    create_table :measurement_values do |t|
      t.decimal :value, null: false, index: true, default: 0.0
      t.references :measurement_group, null: false
      t.references :measurement_name, null: false
      t.timestamps
    end

  end
end
