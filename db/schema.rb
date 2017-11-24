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

ActiveRecord::Schema.define(version: 20171124145038) do

  create_table "annotation_anchors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "annotation_id"
    t.float   "x",             limit: 24
    t.float   "y",             limit: 24
    t.index ["annotation_id"], name: "index_annotation_anchors_on_annotation_id", using: :btree
  end

  create_table "annotations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "annotatable_id"
    t.integer "image_id"
    t.string  "annotation_type"
    t.string  "annotatable_type"
    t.integer "user_id",                          null: false
    t.integer "color_id",         default: 1
    t.boolean "archived",         default: false
    t.index ["annotatable_id", "annotatable_type"], name: "index_annotations_on_annotatable_id_and_annotatable_type", using: :btree
    t.index ["annotation_type"], name: "index_annotations_on_annotation_type", using: :btree
    t.index ["archived"], name: "index_annotations_on_archived", using: :btree
    t.index ["image_id"], name: "index_annotations_on_image_id", using: :btree
    t.index ["user_id"], name: "index_annotations_on_user_id", using: :btree
  end

  create_table "care_labels", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "icon"
  end

  create_table "care_labels_materials", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "care_label_id"
    t.integer "material_id"
    t.index ["care_label_id"], name: "index_care_labels_materials_on_care_label_id", using: :btree
    t.index ["material_id"], name: "index_care_labels_materials_on_material_id", using: :btree
  end

  create_table "colors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name",     null: false
    t.string "hex_code", null: false
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "text",             limit: 65535,                 null: false
    t.integer  "user_id"
    t.integer  "commentable_id",                                 null: false
    t.string   "commentable_type",                               null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "organization_id"
    t.boolean  "archived",                       default: false
    t.string   "key"
    t.index ["archived"], name: "index_comments_on_archived", using: :btree
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
    t.index ["key"], name: "index_comments_on_key", unique: true, using: :btree
    t.index ["organization_id"], name: "index_comments_on_organization_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "components", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "project_id",                                           null: false
    t.integer  "material_id",                                          null: false
    t.decimal  "quantity",    precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.index ["created_at"], name: "index_components_on_created_at", using: :btree
    t.index ["material_id"], name: "index_components_on_material_id", using: :btree
    t.index ["project_id"], name: "index_components_on_project_id", using: :btree
    t.index ["updated_at"], name: "index_components_on_updated_at", using: :btree
  end

  create_table "currencies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name",     null: false
    t.string "iso_code", null: false
    t.string "unicode",  null: false
  end

  create_table "development_stages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "label", null: false
  end

  create_table "images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "url",                               null: false
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.integer  "organization_id",                   null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "user_id"
    t.boolean  "primary",           default: false
    t.index ["created_at"], name: "index_images_on_created_at", using: :btree
    t.index ["imageable_id", "imageable_type"], name: "index_images_on_imageable_id_and_imageable_type", using: :btree
    t.index ["organization_id"], name: "index_images_on_organization_id", using: :btree
    t.index ["primary"], name: "index_images_on_primary", using: :btree
    t.index ["updated_at"], name: "index_images_on_updated_at", using: :btree
    t.index ["user_id"], name: "index_images_on_user_id", using: :btree
  end

  create_table "instructions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "description", limit: 65535
    t.integer  "project_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["created_at"], name: "index_instructions_on_created_at", using: :btree
    t.index ["project_id"], name: "index_instructions_on_project_id", using: :btree
    t.index ["updated_at"], name: "index_instructions_on_updated_at", using: :btree
  end

  create_table "invites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "email",                          null: false
    t.integer "invitable_id",                   null: false
    t.string  "key",                            null: false
    t.boolean "accepted",       default: false, null: false
    t.string  "invitable_type",                 null: false
    t.string  "name"
    t.integer "role_type_id",                   null: false
    t.integer "inviter_id"
    t.index ["accepted"], name: "index_invites_on_accepted", using: :btree
    t.index ["email"], name: "index_invites_on_email", using: :btree
    t.index ["invitable_id", "invitable_type"], name: "index_invites_on_invitable_id_and_invitable_type", using: :btree
    t.index ["key"], name: "index_invites_on_key", using: :btree
  end

  create_table "material_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_material_types_on_name", using: :btree
  end

  create_table "materials", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "material_type_id",                                          null: false
    t.string   "name",                                                      null: false
    t.string   "reference"
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
    t.string   "color"
    t.string   "yarn_count"
    t.string   "weight"
    t.string   "width"
    t.integer  "unit_type_id"
    t.string   "supplier_name"
    t.string   "supplier_email"
    t.boolean  "archived",                                  default: false
    t.index ["archived"], name: "index_materials_on_archived", using: :btree
    t.index ["material_type_id"], name: "index_materials_on_material_type_id", using: :btree
    t.index ["name"], name: "index_materials_on_name", using: :btree
    t.index ["organization_id"], name: "index_materials_on_organization_id", using: :btree
    t.index ["reference"], name: "index_materials_on_reference", using: :btree
    t.index ["supplier_id"], name: "index_materials_on_supplier_id", using: :btree
    t.index ["unit_type_id"], name: "index_materials_on_unit_type_id", using: :btree
  end

  create_table "measurement_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "order"
    t.index ["created_at"], name: "index_measurement_groups_on_created_at", using: :btree
    t.index ["order"], name: "index_measurement_groups_on_order", using: :btree
    t.index ["project_id"], name: "index_measurement_groups_on_project_id", using: :btree
    t.index ["updated_at"], name: "index_measurement_groups_on_updated_at", using: :btree
  end

  create_table "measurement_names", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "value"
    t.integer  "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "order"
    t.index ["created_at"], name: "index_measurement_names_on_created_at", using: :btree
    t.index ["order"], name: "index_measurement_names_on_order", using: :btree
    t.index ["project_id"], name: "index_measurement_names_on_project_id", using: :btree
    t.index ["updated_at"], name: "index_measurement_names_on_updated_at", using: :btree
    t.index ["value"], name: "index_measurement_names_on_value", using: :btree
  end

  create_table "measurement_values", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "value"
    t.integer  "measurement_group_id", null: false
    t.integer  "measurement_name_id",  null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["measurement_group_id"], name: "index_measurement_values_on_measurement_group_id", using: :btree
    t.index ["measurement_name_id"], name: "index_measurement_values_on_measurement_name_id", using: :btree
    t.index ["value"], name: "index_measurement_values_on_value", using: :btree
  end

  create_table "notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "receiver_id"
    t.string   "concern_type"
    t.integer  "concern_id"
    t.string   "notification_type"
    t.boolean  "seen",              default: false
    t.boolean  "email_sent",        default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["concern_type", "concern_id"], name: "index_notifications_on_concern_type_and_concern_id", using: :btree
    t.index ["created_at"], name: "index_notifications_on_created_at", using: :btree
    t.index ["email_sent"], name: "index_notifications_on_email_sent", using: :btree
    t.index ["notification_type"], name: "index_notifications_on_notification_type", using: :btree
    t.index ["receiver_id"], name: "index_notifications_on_receiver_id", using: :btree
    t.index ["seen"], name: "index_notifications_on_seen", using: :btree
  end

  create_table "organizations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_organizations_on_name", using: :btree
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                              null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "collection"
    t.string   "ref_number"
    t.string   "notes"
    t.boolean  "archived",          default: false
    t.integer  "organization_id",                   null: false
    t.string   "color_code"
    t.string   "target_fob"
    t.string   "development_stage"
    t.index ["archived"], name: "index_projects_on_archived", using: :btree
    t.index ["collection"], name: "index_projects_on_collection", using: :btree
    t.index ["created_at"], name: "index_projects_on_created_at", using: :btree
    t.index ["development_stage"], name: "index_projects_on_development_stage", using: :btree
    t.index ["name"], name: "index_projects_on_name", using: :btree
    t.index ["organization_id"], name: "index_projects_on_organization_id", using: :btree
    t.index ["ref_number"], name: "index_projects_on_ref_number", using: :btree
    t.index ["updated_at"], name: "index_projects_on_updated_at", using: :btree
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "roleable_id",               null: false
    t.integer "user_id",                   null: false
    t.integer "role_type_id",  default: 1, null: false
    t.string  "roleable_type",             null: false
    t.index ["role_type_id"], name: "index_roles_on_role_type_id", using: :btree
    t.index ["roleable_id", "roleable_type"], name: "index_roles_on_roleable_id_and_roleable_type", using: :btree
    t.index ["user_id"], name: "index_roles_on_user_id", using: :btree
  end

  create_table "suppliers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",              null: false
    t.string   "agent"
    t.string   "ref"
    t.string   "color_ref"
    t.integer  "minimum_order"
    t.string   "comments"
    t.integer  "organization_id",   null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "email"
    t.string   "country_of_origin"
    t.index ["created_at"], name: "index_suppliers_on_created_at", using: :btree
    t.index ["name"], name: "index_suppliers_on_name", using: :btree
    t.index ["organization_id"], name: "index_suppliers_on_organization_id", using: :btree
    t.index ["updated_at"], name: "index_suppliers_on_updated_at", using: :btree
  end

  create_table "unit_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "name", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "auth0_id",                null: false
    t.integer  "current_organization_id"
    t.string   "username"
    t.index ["auth0_id"], name: "index_users_on_auth0_id", using: :btree
    t.index ["created_at"], name: "index_users_on_created_at", using: :btree
    t.index ["name"], name: "index_users_on_name", using: :btree
    t.index ["updated_at"], name: "index_users_on_updated_at", using: :btree
    t.index ["username"], name: "index_users_on_username", using: :btree
  end

end
