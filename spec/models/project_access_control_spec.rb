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
require 'rails_helper'

RSpec.describe ProjectAccessControl, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
