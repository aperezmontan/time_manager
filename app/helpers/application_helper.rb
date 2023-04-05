# frozen_string_literal: true

# The parent class for all Helpers
module ApplicationHelper
  Link = Struct.new(:name, :path, :options, keyword_init: true)

  HEADER_LINKS = {
    how_to: Link.new(name: 'How to...', path: 'https://www.youtube.com/@ikn8228/playlists'),
    feedback: Link.new(name: 'Feedback', path: '/feedbacks/new'),
    about: Link.new(name: 'About', path: 'https://aperezmontan.github.io/blog'),
    # LOGOUT SHOULD ALWAYS BE LAST
    logout: Link.new(name: 'Logout', path: '/users/sign_out',
                     options: { data: { turbo_method: :delete }, class: 'btn bg-red-600 text-white' })
  }.freeze
end
