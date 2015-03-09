require 'test_helper'
require 'Mocha'
class PointsCreationAndViewingTest < ActionController::TestCase
  include Capybara::DSL
  attr_reader:user
  attr_reader:admin

  def setup
    @user = User.first
    @admin = User.last
  end

  test "a logged in user can view their points" do
    skip
    login_user
    visit '/users/1'
    assert page.has_content?("Points: 3")
  end

  test "a user cannot access admin's options in points section" do
    skip
    login_user
    visit '/points'
    assert page.has_content?("DJ's points: 3")
    refute page.has_content?("Kaitryn's points: 0")
  end

  test "an admin can view all users and their corresponding points" do
    skip
    login_admin
    visit '/points'
     assert page.has_content?("Add points")
     assert page.has_content?("DJ")
     assert page.has_content?("Kaitryn")
  end

  test "an admin can add and destroy points" do
    skip
    login_admin
    visit '/points'
    assert_equal 3, User.first.points.count
    click_link_or_button "Add-DJ"
    assert_equal 4, User.first.points.count
    click_link_or_button "Delete-DJ"
    assert_equal 3, User.first.points.count


    click_link_or_button("Edit-DJ")
    assert_equal 3, User.first.points.count
    fill_in "Add points", with: "3"
    click_link_or_button("Submit")
    assert_equal 6, User.first.points.count

    click_link_or_button("Edit-DJ")
    fill_in "Delete points", with: "5"
    click_link_or_button("Submit")
    assert_equal 1, User.first.points.count
  end

  test "an admin can edit a users points" do
    skip
    login_admin
    visit '/points'
    click_link_or_button("Edit-DJ")
    assert_equal 3, User.first.points.all.where(status: false)
    fill_in "Redeem", with: "2"
    click_link_or_button("Submit")
    assert_equal 1, User.first.points.all.where(status: false)
    assert_equal 2, User.first.points.all.where(status: true)

    click_link_or_button("Edit-DJ")
    fill_in "UnRedeem", with: "1"
    click_link_or_button("Submit")
    assert_equal 2, User.first.points.all.where(status: false)
  end
end
