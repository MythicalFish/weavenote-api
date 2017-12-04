class AddSubscriptionIdToOrganization < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations_subscriptions do |t|
      t.integer :organization_id, null: false
      t.integer :subscription_id, null: false
    end

  end
end
