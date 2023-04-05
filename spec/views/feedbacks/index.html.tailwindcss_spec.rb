# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'feedbacks/index', type: :view do
  before(:each) do
    assign(:feedbacks, [
             Feedback.create!(
               user: nil,
               body: 'MyText'
             ),
             Feedback.create!(
               user: nil,
               body: 'MyText'
             )
           ])
  end

  it 'renders a list of feedbacks' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('MyText'.to_s), count: 2
  end
end
