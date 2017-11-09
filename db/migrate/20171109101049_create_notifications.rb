class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :creator_id, required: true
      t.integer :receiver_id, required: true
      t.string :concern_type
      t.integer :concern_id
      t.integer :type
      t.boolean :unread, default: true
      t.timestamps
    end
    add_index :notifications, :creator_id 
    add_index :notifications, :receiver_id 
    add_index :notifications, [:concern_type, :concern_id]
    add_index :notifications, :unread
    add_index :notifications, :type
    add_index :notifications, :created_at
  end
end
