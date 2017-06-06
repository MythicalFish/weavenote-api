class RestoreCareLabels < ActiveRecord::Migration[5.0]
  def change
    create_table :care_labels do |t|
      t.string :name, null: false
      t.string :icon
    end
  end
end
