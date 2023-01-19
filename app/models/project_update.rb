# frozen_string_literal: true

# The records that save users stops and starts with detailed information
class ProjectUpdate < ApplicationRecord
  belongs_to :project

  # Have to do it like this because for some reason I get an undefined method error
  # if I try to put it in a helper or concern 🤷‍♂️
  enum time_status: { start: 'start', pause: 'pause', hold: 'hold', finish: 'finish' }
  enum reason: { blocked_by_SME: 'blocked_by_SME', other: 'other' }
end
