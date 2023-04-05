# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'feedbacks/new', type: :view do
  before(:each) do
    assign(:feedback, Feedback.new(
                        user: nil,
                        body: 'MyText'
                      ))
  end

  it 'renders new feedback form' do
    render

    assert_select 'form[action=?][method=?]', feedbacks_path, 'post' do
      assert_select 'input[name=?]', 'feedback[user_id]'

      assert_select 'textarea[name=?]', 'feedback[body]'
    end
  end
end
