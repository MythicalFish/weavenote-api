class AddImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :name
      t.string :url, null: false
      t.references :project
    end
  end
end
