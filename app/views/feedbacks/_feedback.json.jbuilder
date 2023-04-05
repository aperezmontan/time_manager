# frozen_string_literal: true

json.extract! feedback, :id, :user_id, :body, :created_at, :updated_at
json.url feedback_url(feedback, format: :json)
