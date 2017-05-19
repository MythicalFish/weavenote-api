class AddInstructions < ActiveRecord::Migration[5.0]
  def change
    create_table :instructions do |t|
      t.string :title
      t.text :description
      t.references :project
    end
  end
end
