class AssociateSuppliersToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :suppliers, :user_id, :integer, index: true
    add_index :materials, :supplier_id
  end
end
