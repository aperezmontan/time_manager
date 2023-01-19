# frozen_string_literal: true

# The main class where users can save their stops and start updates
class Project < ApplicationRecord
  # ASSOCIATIONS
  has_many :project_updates, dependent: :destroy, autosave: true

  # VALIDATIONS
  validates :name, presence: true
end
