class Project < ApplicationRecord
  # ASSOCIATIONS
  has_many :project_updates, dependent: :destroy, autosave: true

  # VALIDATIONS
  validates_presence_of :name
end
