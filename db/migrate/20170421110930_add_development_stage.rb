class AddDevelopmentStage < ActiveRecord::Migration[5.0]
  def change
    create_table :development_stages do |t|
      t.string :label, null: false
    end
  end
end
