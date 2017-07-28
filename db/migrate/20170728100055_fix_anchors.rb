class FixAnchors < ActiveRecord::Migration[5.0]
  def change
    add_column :annotation_anchors, :x, :float, precision: 10
    add_column :annotation_anchors, :y, :float, precision: 10
  end
end
