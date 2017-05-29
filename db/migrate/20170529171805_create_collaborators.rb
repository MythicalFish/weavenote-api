class CreateCollaborators < ActiveRecord::Migration[5.0]
  def change
    create_table :collaborators do |t|
      t.string :email, null: false, index: true
      t.string :name, null: false, index: true
      t.integer :project_id, null: false, index: true
    end
  end
end
