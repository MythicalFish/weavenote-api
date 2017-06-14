class AddAttributesToInvites < ActiveRecord::Migration[5.0]
  def change
    add_column :invites, :name, :string
    add_column :invites, :role_type_id, :integer, null: false
  end
end
