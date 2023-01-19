# frozen_string_literal: true

# The parent class for all Mailers
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
