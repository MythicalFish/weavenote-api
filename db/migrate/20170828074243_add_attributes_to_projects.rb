class AddAttributesToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :color_code, :string
    add_column :projects, :target_fob, :string
    rename_column :projects, :identifier, :ref_number
    rename_column :projects, :description, :notes
    rename_column :projects, :category, :collection
  end
end
