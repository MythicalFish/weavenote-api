class RenameLabelLabel < ActiveRecord::Migration[5.0]
  def change
    rename_column :care_labels, :label, :name
  end
end
