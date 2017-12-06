class AddTestAccountColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :test_account, :boolean, default: false
  end
end
