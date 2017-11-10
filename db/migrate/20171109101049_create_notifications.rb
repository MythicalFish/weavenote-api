class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :receiver_id, required: true
      t.string :concern_type
      t.integer :concern_id
      t.string :notification_type
      t.boolean :seen, default: false
      t.boolean :email_sent, default: false
      t.timestamps
    end
    add_index :notifications, :receiver_id 
    add_index :notifications, [:concern_type, :concern_id]
    add_index :notifications, :seen
    add_index :notifications, :email_sent
    add_index :notifications, :notification_type
    add_index :notifications, :created_at
  end
end
