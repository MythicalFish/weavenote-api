class CreateAnnotations < ActiveRecord::Migration[5.0]
  def change
    create_table :annotations do |t|
      t.references :annotatable
      t.references :image
      t.string :type, index: true
    end
    create_table :annotation_anchors do |t|
      t.references :annotation
    end
  end
end
