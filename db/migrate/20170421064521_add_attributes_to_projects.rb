class AddAttributesToProjects < ActiveRecord::Migration[5.0]
  def change

    add_column :projects, :user_id, :integer, null: false
    add_index :projects, :user_id

    rename_column :projects, :title, :name
    add_index :projects, :name
    change_column :projects, :name, :string, null: false

    add_column :projects, :development_stage, :string
    add_index :projects, :development_stage
    add_column :projects, :type, :string
    add_index :projects, :type
    add_column :projects, :identifier, :string, null: false
    add_index :projects, :identifier
    add_column :projects, :description, :string

  end
end
