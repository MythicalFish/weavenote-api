class ChangeDevStage < ActiveRecord::Migration[5.0]
  def change
    remove_column :projects, :development_stage_id
    add_column :projects, :development_stage, :string
    add_index :projects, :development_stage
  end
end
