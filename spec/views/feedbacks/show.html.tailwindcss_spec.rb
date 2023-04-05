# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'feedbacks/show', type: :view do
  before(:each) do
    assign(:feedback, Feedback.create!(
                        user: nil,
                        body: 'MyText'
                      ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
  end
end
