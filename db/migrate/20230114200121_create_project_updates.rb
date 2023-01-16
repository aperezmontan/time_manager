class CreateProjectUpdates < ActiveRecord::Migration[7.0]
  def change
    create_table :project_updates do |t|
      t.integer :time_status
      t.integer :reason
      t.text :note
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
