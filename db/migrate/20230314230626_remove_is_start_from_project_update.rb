class RemoveIsStartFromProjectUpdate < ActiveRecord::Migration[7.0]
  def change
    remove_column :project_updates, :is_start, :boolean
  end

  def down
    add_column :project_updates, :is_start, :boolean, default: true, null: false
  end
end
