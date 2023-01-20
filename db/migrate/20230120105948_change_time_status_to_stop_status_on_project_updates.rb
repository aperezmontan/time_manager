class ChangeTimeStatusToStopStatusOnProjectUpdates < ActiveRecord::Migration[7.0]
  def change
    rename_column :project_updates, :time_status, :stop_status
  end
end
