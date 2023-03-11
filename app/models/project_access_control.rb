# frozen_string_literal: true

# The records that save users access to the projects
class ProjectAccessControl < ApplicationRecord
  belongs_to :project
  belongs_to :user

  enum level: {
    owner: 'owner',
    view: 'view',
    edit: 'edit'
  }
end
