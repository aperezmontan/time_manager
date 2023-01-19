# frozen_string_literal: true

class UpdateTimeStatusAndReasonOnProjectUpdates < ActiveRecord::Migration[7.0]
  def up
    remove_column :project_updates, :time_status
    execute <<-SQL
      CREATE TYPE project_update_time_status AS ENUM ('start', 'pause', 'hold', 'finish');
    SQL
    add_column :project_updates, :time_status, :project_update_time_status
    add_index :project_updates, :time_status

    remove_column :project_updates, :reason
    execute <<-SQL
      CREATE TYPE project_update_reason AS ENUM ('blocked_by_SME', 'other');
    SQL
    add_column :project_updates, :reason, :project_update_reason
    add_index :project_updates, :reason
  end

  def down
    remove_index :project_updates, :time_status
    remove_column :project_updates, :time_status
    execute <<-SQL
      DROP TYPE project_update_time_status;
    SQL
    add_column :project_updates, :time_status, :integer

    remove_index :project_updates, :reason
    remove_column :project_updates, :reason
    execute <<-SQL
      DROP TYPE project_update_reason;
    SQL
    add_column :project_updates, :reason, :integer
  end
end
