# frozen_string_literal: true

# == Schema Information
#
# Table name: project_access_controls
#
#  id         :bigint           not null, primary key
#  project_id :bigint           not null
#  user_id    :bigint           not null
#  level      :enum             default("view"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
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
