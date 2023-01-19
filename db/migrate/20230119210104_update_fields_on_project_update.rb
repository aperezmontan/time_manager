class UpdateFieldsOnProjectUpdate < ActiveRecord::Migration[7.0]
  def change
    rename_column :project_updates, :reason, :stop_reason
    add_column :project_updates, :is_start, :boolean, default: true, null: false
  end
end
