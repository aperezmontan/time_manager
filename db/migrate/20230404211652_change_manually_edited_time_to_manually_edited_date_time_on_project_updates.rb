class ChangeManuallyEditedTimeToManuallyEditedDateTimeOnProjectUpdates < ActiveRecord::Migration[7.0]
  def change
    rename_column :project_updates, :manually_edited_time, :manually_edited_datetime
  end
end
