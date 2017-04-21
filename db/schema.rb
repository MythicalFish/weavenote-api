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

ActiveRecord::Schema.define(version: 20170421110930) do

  create_table "development_stage", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "label", null: false
  end

  create_table "images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.string  "url",        null: false
    t.integer "project_id"
    t.index ["project_id"], name: "index_images_on_project_id", using: :btree
  end

  create_table "materials", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type",       null: false
    t.string   "name",       null: false
    t.string   "identifier", null: false
    t.integer  "price"
    t.integer  "quantity"
    t.string   "color"
    t.integer  "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["color"], name: "index_materials_on_color", using: :btree
    t.index ["identifier"], name: "index_materials_on_identifier", using: :btree
    t.index ["name"], name: "index_materials_on_name", using: :btree
    t.index ["price"], name: "index_materials_on_price", using: :btree
    t.index ["project_id"], name: "index_materials_on_project_id", using: :btree
    t.index ["quantity"], name: "index_materials_on_quantity", using: :btree
    t.index ["type"], name: "index_materials_on_type", using: :btree
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",              null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "user_id",           null: false
    t.string   "development_stage"
    t.string   "type"
    t.string   "identifier",        null: false
    t.string   "description"
    t.index ["development_stage"], name: "index_projects_on_development_stage", using: :btree
    t.index ["identifier"], name: "index_projects_on_identifier", using: :btree
    t.index ["name"], name: "index_projects_on_name", using: :btree
    t.index ["type"], name: "index_projects_on_type", using: :btree
    t.index ["user_id"], name: "index_projects_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
