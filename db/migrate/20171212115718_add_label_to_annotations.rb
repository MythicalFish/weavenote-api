class AddLabelToAnnotations < ActiveRecord::Migration[5.0]
  def change
    add_column :annotations, :label, :string
  end
end
