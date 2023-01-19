# frozen_string_literal: true

# Helper for Project views
module ProjectsHelper
  STATUSES = {
    'start' => 'Started',
    'pause' => 'Paused',
    'hold' => 'On hold',
    'finish' => 'Finished'
  }.freeze
  def current_status_in_past(status)
    STATUSES[status]
  end
end
