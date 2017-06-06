class RestoreTables < ActiveRecord::Migration[5.0]
  def change
    create_table :colors do |t|
      t.string :name,     null: false
      t.string :hex_code, null: false
    end
    create_table "currencies" do |t|
      t.string "name",     null: false
      t.string "iso_code", null: false
      t.string "unicode",  null: false
    end
    create_table "material_types" do |t|
      t.string "name", null: false
      t.index ["name"], name: "index_material_types_on_name", using: :btree
    end
    create_table "development_stages" do |t|
      t.string "label", null: false
    end
    create_table "role_types" do |t|
      t.string "name", null: false
    end
  end
end
