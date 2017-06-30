class AddInviterToInvites < ActiveRecord::Migration[5.0]
  def change
    add_column :invites, :inviter_id, :integer
  end
end
