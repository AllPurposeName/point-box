require 'test_helper'
require 'Mocha'
class UsersAuthenticationTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  test "a guest visiting a users page is presented with a login" do
    logout
    visit '/users/1'
    assert_equal '/login', current_path
    within("#flash-alert") do
      assert page.has_content?("Not authorized")
    end
  end

  test "a user can log in and see their profile" do
    visit '/login'
    fill_in "session[name]", with:("DJ")
    fill_in "session[password]", with:("pw")
    click_link_or_button("Login")
    assert_equal '/users/1', current_path
  end

  test "a logged in user cannot view a different user's profile" do
    login_user
    visit '/users/2'
    within("#flash-alert") do
      assert page.has_content?("You are not authorized")
    end
    assert_equal '/users/1', current_path
  end

  test "a user cannot access admin's options in rewards section" do
    login_user
    visit '/rewards'
    refute page.has_content?("Create reward")
  end

  test "a user cannot access admin's options in users section" do
    login_user
    visit '/users'
    refute page.has_content?("Add points")
  end

  test "a user redeems only their points when they claim a reward" do
    login_user
    visit '/rewards'
    assert_equal 3, User.first.points.all.where(status: false).count
    assert_equal 1, User.last.points.all.where(status: false).count
    within "#black-ball" do
      click_link_or_button "Purchase"
    end
    assert_equal 2, User.first.points.all.where(status: false).count
    assert_equal 1, User.last.points.all.where(status: false).count
  end
end
