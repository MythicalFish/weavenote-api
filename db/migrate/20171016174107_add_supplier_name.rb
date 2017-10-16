class AddSupplierName < ActiveRecord::Migration[5.0]
  def change
    add_column :materials, :supplier_name, :string
    add_column :materials, :supplier_email, :string
  end
end
