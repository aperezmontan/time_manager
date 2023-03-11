class CreateProjectAccessControls < ActiveRecord::Migration[7.0]
  def up
    create_enum :level, ["owner", "view", "edit"]
    create_table :project_access_controls do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.enum :level, enum_type: "level", default: "view", null: false

      t.timestamps
    end
    add_index :project_access_controls, [ :project_id, :user_id ], :unique => true, :name => 'by_project_and_user'
  end

  def down
    remove_index :project_access_controls, name: 'by_project_and_user'
    drop_table :project_access_controls

    execute <<-SQL
      DROP TYPE level;
    SQL
  end
end
