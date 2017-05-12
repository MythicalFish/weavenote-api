class ChancePriceAndQuantityToDecimal < ActiveRecord::Migration[5.0]
  def change
    change_column :components, :quantity, :decimal, precision: 10, scale: 2
    change_column :materials, :price, :decimal, precision: 10, scale: 2
  end
end
