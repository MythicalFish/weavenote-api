class AddMeasurements < ActiveRecord::Migration[5.0]
  def change

    create_table :sizes do |t|
      t.string :label, null: false
      t.integer :project_id, null: false, index: true
    end
    
    create_table :measurements do |t|
      t.string :label, null: false, index: true
      t.integer :project_id, null: false, index: true
      t.timestamps
    end

    create_table :measurement_values do |t|
      t.decimal :value, null: false, index: true
      t.references :measurement, null: false
      t.references :size, null: false
      t.timestamps
    end

  end
end
