class AddAttributesToAnnotation < ActiveRecord::Migration[5.0]
  def change
    add_column :annotations, :color_id, :integer, default: 1
  end
end
