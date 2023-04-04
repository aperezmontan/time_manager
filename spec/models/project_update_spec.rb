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
require 'rails_helper'

RSpec.describe ProjectUpdate, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
