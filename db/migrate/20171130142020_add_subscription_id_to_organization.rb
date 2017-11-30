class AddSubscriptionIdToOrganization < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :subscription_id, :integer
  end
end
