# frozen_string_literal: true

# The records that save users stops and starts with detailed information
class ProjectUpdate < ApplicationRecord
  belongs_to :project

  # Have to do it like this because for some reason I get an undefined method error
  # if I try to put it in a helper or concern 🤷‍♂️
  enum stop_status: { start: 'start', pause: 'pause', hold: 'hold', finish: 'finish' }
  enum reason: { blocked_by_SME: 'blocked_by_SME', other: 'other' }

  # VALIDATIONS
  validates :stop_status, presence: { unless: :is_start }

  # ATTEMPT TO BE MORE EFFICIENT
  # def self.latest_updates_for_projects
  #   latest_updates_ids = select(:id).order(manually_edited_time: :desc).group(:project_id).limit(1)
  #   where(id: latest_updates_ids)
  # end
end
