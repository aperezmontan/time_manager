# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'feedbacks/edit', type: :view do
  let(:feedback) do
    Feedback.create!(
      user: nil,
      body: 'MyText'
    )
  end

  before(:each) do
    assign(:feedback, feedback)
  end

  it 'renders the edit feedback form' do
    render

    assert_select 'form[action=?][method=?]', feedback_path(feedback), 'post' do
      assert_select 'input[name=?]', 'feedback[user_id]'

      assert_select 'textarea[name=?]', 'feedback[body]'
    end
  end
end
