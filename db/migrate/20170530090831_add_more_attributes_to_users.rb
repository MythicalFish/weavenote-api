class AddMoreAttributesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :access_level, :integer, default: 1, index: true
    
    create_join_table :projects, :users do |t|
      t.index :project_id
      t.index :user_id
    end

  end
end
