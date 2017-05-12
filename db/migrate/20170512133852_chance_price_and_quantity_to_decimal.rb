class ChancePriceAndQuantityToDecimal < ActiveRecord::Migration[5.0]
  def change
    change_column :components, :quantity, :decimal, precision: 10, scale: 2, default: 0
    change_column :materials, :price, :decimal, precision: 10, scale: 2, default: 0
  end
end
