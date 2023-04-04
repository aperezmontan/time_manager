# == Schema Information
#
# Table name: feedbacks
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Feedback < ApplicationRecord
  belongs_to :user
end
