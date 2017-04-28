class AddDefaultValueToProjectsDevelopmentStage < ActiveRecord::Migration[5.0]
  def change
    change_column :projects, :development_stage_id, :integer, null: false, default: 1
  end
end
