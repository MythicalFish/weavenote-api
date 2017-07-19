class AddOrganizationToComment < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :organization_id, :integer
    add_index :comments, :organization_id
  end
end
