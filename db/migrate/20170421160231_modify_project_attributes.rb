class ModifyProjectAttributes < ActiveRecord::Migration[5.0]
  def change
    rename_column :projects, :type, :category
    rename_column :projects, :development_stage, :development_stage_id
    change_column :projects, :development_stage_id, :integer
  end
end
