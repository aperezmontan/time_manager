# frozen_string_literal: true

# The parent class for all Controllers
class ApplicationController < ActionController::Base
  include Pundit::Authorization
end
