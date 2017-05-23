class AssociateSuppliersToUser < ActiveRecord::Migration[5.0]
  def change
    add_index :materials, :supplier_id
  end
end
