class UpdateFieldsOnProjectUpdate < ActiveRecord::Migration[7.0]
  def change
    add_column :project_updates, :is_start, :boolean, default: true, null: false
    add_column :project_updates, :manually_edited_time, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
