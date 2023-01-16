module ProjectsHelper
  STATUSES = {
    "start" => "Started",
    "pause" => "Paused",
    "hold" => "On hold",
    "finish" => "Finished"
  }
  def current_status_in_past(status)
    STATUSES[status]
  end
end
