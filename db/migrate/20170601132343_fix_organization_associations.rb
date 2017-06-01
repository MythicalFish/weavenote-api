class FixOrganizationAssociations < ActiveRecord::Migration[5.0]
  def change
    remove_column :suppliers, :user_id
    add_column :suppliers, :organization_id, :integer, null: false, index: true
    remove_column :materials, :user_id
    add_column :materials, :organization_id, :integer, null: false, index: true
  end
end
