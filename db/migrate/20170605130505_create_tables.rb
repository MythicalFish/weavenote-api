class CreateTables < ActiveRecord::Migration[5.0]
  def up

    create_table "care_labels_materials", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.integer "care_label_id"
      t.integer "material_id"
      t.index ["care_label_id"], name: "index_care_labels_materials_on_care_label_id", using: :btree
      t.index ["material_id"], name: "index_care_labels_materials_on_material_id", using: :btree
    end

    create_table "collaborators", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string  "email",      null: false
      t.string  "name",       null: false
      t.integer "project_id", null: false
      t.index ["email"], name: "index_collaborators_on_email", using: :btree
      t.index ["name"], name: "index_collaborators_on_name", using: :btree
      t.index ["project_id"], name: "index_collaborators_on_project_id", using: :btree
    end

    create_table "components", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.integer "project_id",                                           null: false
      t.integer "material_id",                                          null: false
      t.decimal "quantity",    precision: 10, scale: 2, default: "0.0"
      t.index ["material_id"], name: "index_components_on_material_id", using: :btree
      t.index ["project_id"], name: "index_components_on_project_id", using: :btree
    end

    create_table "images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string  "name"
      t.string  "url",             null: false
      t.integer "imageable_id"
      t.string  "imageable_type"
      t.integer "organization_id", null: false
      t.index ["imageable_id", "imageable_type"], name: "index_images_on_imageable_id_and_imageable_type", using: :btree
      t.index ["imageable_id"], name: "index_images_on_imageable_id", using: :btree
    end

    create_table "instructions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string  "title"
      t.text    "description", limit: 65535
      t.integer "project_id"
      t.index ["project_id"], name: "index_instructions_on_project_id", using: :btree
    end

    create_table "invitations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string  "email",                           null: false
      t.integer "organization_id",                 null: false
      t.string  "key",                             null: false
      t.boolean "accepted",        default: false, null: false
      t.index ["accepted"], name: "index_invitations_on_accepted", using: :btree
      t.index ["email"], name: "index_invitations_on_email", using: :btree
      t.index ["key"], name: "index_invitations_on_key", using: :btree
      t.index ["organization_id"], name: "index_invitations_on_organization_id", using: :btree
    end

    create_table "materials", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.integer  "material_type_id",                                          null: false
      t.string   "name",                                                      null: false
      t.string   "identifier",                                                null: false
      t.integer  "color_id"
      t.datetime "created_at",                                                null: false
      t.datetime "updated_at",                                                null: false
      t.integer  "currency_id",                                               null: false
      t.integer  "supplier_id"
      t.decimal  "cost_base",        precision: 10, scale: 2, default: "0.0"
      t.decimal  "cost_delivery",    precision: 10, scale: 2, default: "0.0"
      t.decimal  "cost_extra1",      precision: 10, scale: 2, default: "0.0"
      t.decimal  "cost_extra2",      precision: 10, scale: 2, default: "0.0"
      t.string   "composition"
      t.string   "size"
      t.string   "length"
      t.string   "opening_type"
      t.string   "subtype"
      t.integer  "organization_id",                                           null: false
      t.index ["color_id"], name: "index_materials_on_color_id", using: :btree
      t.index ["identifier"], name: "index_materials_on_identifier", using: :btree
      t.index ["material_type_id"], name: "index_materials_on_material_type_id", using: :btree
      t.index ["name"], name: "index_materials_on_name", using: :btree
      t.index ["supplier_id"], name: "index_materials_on_supplier_id", using: :btree
    end

    create_table "measurement_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string  "name",       null: false
      t.integer "project_id", null: false
      t.index ["project_id"], name: "index_measurement_groups_on_project_id", using: :btree
    end

    create_table "measurement_names", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string   "value",      null: false
      t.integer  "project_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_measurement_names_on_project_id", using: :btree
      t.index ["value"], name: "index_measurement_names_on_value", using: :btree
    end

    create_table "measurement_values", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.decimal  "value",                precision: 10, default: 0, null: false
      t.integer  "measurement_group_id",                            null: false
      t.integer  "measurement_name_id",                             null: false
      t.datetime "created_at",                                      null: false
      t.datetime "updated_at",                                      null: false
      t.index ["measurement_group_id"], name: "index_measurement_values_on_measurement_group_id", using: :btree
      t.index ["measurement_name_id"], name: "index_measurement_values_on_measurement_name_id", using: :btree
      t.index ["value"], name: "index_measurement_values_on_value", using: :btree
    end

    create_table "organizations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string "name", null: false
      t.index ["name"], name: "index_organizations_on_name", using: :btree
    end

    create_table "organizations_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.integer "organization_id",             null: false
      t.integer "user_id",                     null: false
      t.integer "role_id",         default: 1, null: false
      t.index ["organization_id"], name: "index_organizations_users_on_organization_id", using: :btree
      t.index ["role_id"], name: "index_organizations_users_on_role_id", using: :btree
      t.index ["user_id"], name: "index_organizations_users_on_user_id", using: :btree
    end

    create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string   "name",                                 null: false
      t.datetime "created_at",                           null: false
      t.datetime "updated_at",                           null: false
      t.integer  "development_stage_id", default: 1,     null: false
      t.string   "category"
      t.string   "identifier",                           null: false
      t.string   "description"
      t.boolean  "archived",             default: false
      t.integer  "organization_id",                      null: false
      t.index ["archived"], name: "index_projects_on_archived", using: :btree
      t.index ["category"], name: "index_projects_on_category", using: :btree
      t.index ["development_stage_id"], name: "index_projects_on_development_stage_id", using: :btree
      t.index ["identifier"], name: "index_projects_on_identifier", using: :btree
      t.index ["name"], name: "index_projects_on_name", using: :btree
    end

    create_table "suppliers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string  "name",            null: false
      t.string  "agent"
      t.string  "ref"
      t.string  "color_ref"
      t.integer "minimum_order"
      t.string  "comments"
      t.integer "organization_id", null: false
      t.index ["name"], name: "index_suppliers_on_name", using: :btree
    end

    create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string   "name"
      t.string   "email"
      t.datetime "created_at",              null: false
      t.datetime "updated_at",              null: false
      t.string   "auth0_id",                null: false
      t.string   "avatar"
      t.integer  "current_organization_id"
      t.index ["auth0_id"], name: "index_users_on_auth0_id", using: :btree
    end

  end
end
