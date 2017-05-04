class AddColors < ActiveRecord::Migration[5.0]
  def change
    create_table :colors do |t|
      t.string :name, null: false
      t.string :hex_code, null: false
    end
  end
end
