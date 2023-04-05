# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Project < ApplicationRecord
  # ASSOCIATIONS
  has_many :project_updates, dependent: :destroy, autosave: true
  # ATTEMPT TO BE MORE EFFICIENT
  # has_one :latest_update, lambda {
  #                           ProjectUpdate.latest_updates_for_projects
  #                         }, class_name: 'ProjectUpdate', inverse_of: :project, dependent: :destroy
  has_many :project_access_controls, dependent: :destroy
  has_many :users, through: :project_access_controls

  # NESTED ATTRIBUTES
  accepts_nested_attributes_for :project_updates

  # VALIDATIONS
  validates :name, presence: true

  # TODO: COUPLING !!
  def owner_ids
    ProjectAccessControl.where(project_id: id, level: 'owner').map(&:user_id)
  end
end
