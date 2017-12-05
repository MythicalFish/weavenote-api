class ModifySubscriptionPlan < ActiveRecord::Migration[5.0]
  def up
    change_column :subscription_plans, :amount, :float
    add_column :subscription_plans, :currency_symbol, :string, default: '&pound;'
  end
  def down
    remove_column :subscription_plans, :currency_symbol
    change_column :subscription_plans, :amount, :integer
  end
end
