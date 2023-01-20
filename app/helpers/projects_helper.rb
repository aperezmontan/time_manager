# frozen_string_literal: true

# Helper for Project views
module ProjectsHelper
  STATUSES = {
    'pause' => 'Paused',
    'hold' => 'On hold',
    'finish' => 'Finished'
  }.freeze

  def current_status_in_words(project_update:)
    get_status(update: project_update)
  end

  def current_status_in_past(project:)
    last_update = last_update(project:)
    return 'Not Started' if last_update.nil?

    get_status(update: last_update)
  end

  def get_status(update:)
    STATUSES.fetch(update.stop_status, 'Started')
  end

  def last_update(project:)
    project.project_updates.order(manually_edited_time: :desc).first
  end

  def last_update_current_status(project:)
    last_update(project:)&.stop_status
  end

  def last_update_is_started?(project:)
    last_update(project:)&.is_start || false
  end
end
