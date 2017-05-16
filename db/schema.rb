# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170515084658) do

  create_table "colors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name",     null: false
    t.string "hex_code", null: false
  end

  create_table "components", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "project_id",                                           null: false
    t.integer "material_id",                                          null: false
    t.decimal "quantity",    precision: 10, scale: 2, default: "0.0"
    t.index ["material_id"], name: "index_components_on_material_id", using: :btree
    t.index ["project_id"], name: "index_components_on_project_id", using: :btree
  end

  create_table "development_stages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "label", null: false
  end

  create_table "images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.string  "url",            null: false
    t.integer "imageable_id"
    t.string  "imageable_type"
    t.index ["imageable_id", "imageable_type"], name: "index_images_on_imageable_id_and_imageable_type", using: :btree
    t.index ["imageable_id"], name: "index_images_on_imageable_id", using: :btree
  end

  create_table "material_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_material_types_on_name", using: :btree
  end

  create_table "materials", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "material_type_id",                                          null: false
    t.string   "name",                                                      null: false
    t.string   "identifier",                                                null: false
    t.decimal  "price",            precision: 10, scale: 2, default: "0.0"
    t.integer  "color_id"
    t.integer  "user_id",                                                   null: false
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.index ["color_id"], name: "index_materials_on_color_id", using: :btree
    t.index ["identifier"], name: "index_materials_on_identifier", using: :btree
    t.index ["material_type_id"], name: "index_materials_on_material_type_id", using: :btree
    t.index ["name"], name: "index_materials_on_name", using: :btree
    t.index ["price"], name: "index_materials_on_price", using: :btree
    t.index ["user_id"], name: "index_materials_on_user_id", using: :btree
  end

  create_table "measurement_values", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.decimal  "value",          precision: 10, default: 0, null: false
    t.integer  "measurement_id",                            null: false
    t.integer  "size_id",                                   null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["measurement_id"], name: "index_measurement_values_on_measurement_id", using: :btree
    t.index ["size_id"], name: "index_measurement_values_on_size_id", using: :btree
    t.index ["value"], name: "index_measurement_values_on_value", using: :btree
  end

  create_table "measurements", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "label",      null: false
    t.integer  "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label"], name: "index_measurements_on_label", using: :btree
    t.index ["project_id"], name: "index_measurements_on_project_id", using: :btree
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                 null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "user_id",                              null: false
    t.integer  "development_stage_id", default: 1,     null: false
    t.string   "category"
    t.string   "identifier",                           null: false
    t.string   "description"
    t.boolean  "archived",             default: false
    t.index ["archived"], name: "index_projects_on_archived", using: :btree
    t.index ["category"], name: "index_projects_on_category", using: :btree
    t.index ["development_stage_id"], name: "index_projects_on_development_stage_id", using: :btree
    t.index ["identifier"], name: "index_projects_on_identifier", using: :btree
    t.index ["name"], name: "index_projects_on_name", using: :btree
    t.index ["user_id"], name: "index_projects_on_user_id", using: :btree
  end

  create_table "sizes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "label",      null: false
    t.integer "project_id", null: false
    t.index ["project_id"], name: "index_sizes_on_project_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "auth0_id",   null: false
    t.string   "avatar"
    t.index ["auth0_id"], name: "index_users_on_auth0_id", using: :btree
  end

end
