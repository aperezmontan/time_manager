# frozen_string_literal: true

# == Schema Information
#
# Table name: project_updates
#
#  id                       :bigint           not null, primary key
#  note                     :text
#  project_id               :bigint           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  reason                   :enum
#  manually_edited_datetime :datetime
#  status                   :enum             default("started")
#
require 'rails_helper'

describe ProjectUpdate do
  let(:project) { Project.create(name: 'Foo') }

  describe 'validations' do
    it 'ensures the time of a manually_edited_datetime is valid' do
      project_update = ProjectUpdate.new(project_id: project.id, manually_edited_date: '4/4/2023',
                                         manually_edited_time: '25:11 PM')
      expect do
        project_update.save!
      end.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Time is not valid')
    end

    it 'ensures the date of a manually_edited_datetime is valid' do
      project_update = ProjectUpdate.new(project_id: project.id, manually_edited_date: '13/45/2023',
                                         manually_edited_time: '11:11 PM')
      expect do
        project_update.save!
      end.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Date is not valid')
    end
  end
end
