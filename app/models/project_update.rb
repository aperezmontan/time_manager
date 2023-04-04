# frozen_string_literal: true

# == Schema Information
#
# Table name: project_updates
#
#  id                   :bigint           not null, primary key
#  note                 :text
#  project_id           :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  reason               :enum
#  manually_edited_time :datetime
#  status               :enum             default("started")
#
# The records that save users stops and starts with detailed information
class ProjectUpdate < ApplicationRecord
  belongs_to :project

  # Have to do it like this because for some reason I get an undefined method error
  # if I try to put it in a helper or concern 🤷‍♂️
  enum status: { started: 'started', stopped: 'stopped', finished: 'finished' }
  enum reason: { out_of_office: 'out_of_office', vacation: 'vacation', funding: 'funding',
                 contract_missing_items: 'contract_missing_items', schedule_conflicts: 'schedule_conflicts',
                 blocked_by_SME: 'blocked_by_SME', other: 'other' }

  # VALIDATIONS
  validates :status, presence: true

  # ATTEMPT TO BE MORE EFFICIENT
  # def self.latest_updates_for_projects
  #   latest_updates_ids = select(:id).order(manually_edited_time: :desc).group(:project_id).limit(1)
  #   where(id: latest_updates_ids)
  # end
end
