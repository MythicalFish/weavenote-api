class RemoveCollaborators < ActiveRecord::Migration[5.0]
  def change
    if ActiveRecord::Base.connection.table_exists? 'collaborators'
      drop_table :collaborators
    end
  end
end
