class RemoveRefNumberRequired < ActiveRecord::Migration[5.0]
  def up
    change_column :projects, :ref_number, :string, null: true
  end
  def down
  end
end
