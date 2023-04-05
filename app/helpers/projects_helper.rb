# frozen_string_literal: true

# Helper for Project views
module ProjectsHelper
  def current_status_in_words(project_update:)
    get_status(update: project_update)
  end

  def current_status_in_past(project:)
    last_update = last_update(project:)
    return 'Not Started' if last_update.nil?

    get_status(update: last_update)
  end

  def get_status(update:)
    update.status.humanize
  end

  def last_update(project:)
    project.project_updates.order(manually_edited_datetime: :desc).first
  end

  def last_update_current_status(project:)
    last_update(project:)&.status
  end

  def last_update_is_started?(project:)
    last_update(project:)&.started? || false
  end
end
