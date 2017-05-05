class ChangeColorToColorId < ActiveRecord::Migration[5.0]
  def change
    change_column :materials, :color, :integer
    rename_column :materials, :color, :color_id
  end
end
