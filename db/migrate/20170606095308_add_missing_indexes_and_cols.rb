class AddMissingIndexesAndCols < ActiveRecord::Migration[5.0]
  def change
    
    add_index :images, :organization_id
    add_index :materials, :organization_id
    add_index :projects, :organization_id
    add_index :projects, :created_at
    add_index :projects, :updated_at
    add_index :suppliers, :organization_id
    add_index :users, :name
    add_index :users, :created_at
    add_index :users, :updated_at
    add_index :measurement_names, :created_at
    add_index :measurement_names, :updated_at
    
    add_column :measurement_groups, :created_at, :datetime, null: false
    add_column :measurement_groups, :updated_at, :datetime, null: false
    add_index :measurement_groups, :created_at
    add_index :measurement_groups, :updated_at

    add_column :instructions, :created_at, :datetime, null: false
    add_column :instructions, :updated_at, :datetime, null: false
    add_index :instructions, :created_at
    add_index :instructions, :updated_at

    add_column :images, :created_at, :datetime, null: false
    add_column :images, :updated_at, :datetime, null: false
    add_index :images, :created_at
    add_index :images, :updated_at

    add_column :components, :created_at, :datetime, null: false
    add_column :components, :updated_at, :datetime, null: false
    add_index :components, :created_at
    add_index :components, :updated_at

    add_column :suppliers, :created_at, :datetime, null: false
    add_column :suppliers, :updated_at, :datetime, null: false
    add_index :suppliers, :created_at
    add_index :suppliers, :updated_at

  end
end
