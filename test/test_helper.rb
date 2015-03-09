ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # Add more helper methods to be used by all tests here...
  
  def login_user
    visit "/login"
    fill_in "session[name]", with: "DJ"
    fill_in "session[password]", with: "pw"
    click_link_or_button("Login")
  end

  def login_admin
    visit "/login"
    fill_in "session[name]", with: "Kaitryn"
    fill_in "session[password]", with: "pw"
    click_link_or_button("Login")
  end
end
