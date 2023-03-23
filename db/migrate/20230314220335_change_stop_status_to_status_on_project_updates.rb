class ChangeStopStatusToStatusOnProjectUpdates < ActiveRecord::Migration[7.0]
  def up
    remove_index :project_updates, :stop_status
    remove_column :project_updates, :stop_status

    execute <<-SQL
      DROP TYPE project_update_time_status;
    SQL

    execute <<-SQL
      CREATE TYPE project_update_status AS ENUM ('started', 'stopped', 'finished');
    SQL

    add_column :project_updates, :status, :project_update_status, default: :started
    add_index :project_updates, :status
  end

  def down
    remove_index :project_updates, :status
    remove_column :project_updates, :status
    execute <<-SQL
      DROP TYPE project_update_status;
    SQL

    execute <<-SQL
      CREATE TYPE project_update_time_status AS ENUM ('start', 'pause', 'hold', 'finish');
    SQL
    add_column :project_updates, :stop_status, :project_update_time_status
    add_index :project_updates, :stop_status
  end
end
