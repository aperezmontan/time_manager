# frozen_string_literal: true

# The main class where users can save their stops and start updates
class Project < ApplicationRecord
  # ASSOCIATIONS
  has_many :project_updates, dependent: :destroy, autosave: true
  # ATTEMPT TO BE MORE EFFICIENT
  # has_one :latest_update, lambda {
  #                           ProjectUpdate.latest_updates_for_projects
  #                         }, class_name: 'ProjectUpdate', inverse_of: :project, dependent: :destroy

  # NESTED ATTRIBUTES
  accepts_nested_attributes_for :project_updates

  # VALIDATIONS
  validates :name, presence: true
end
