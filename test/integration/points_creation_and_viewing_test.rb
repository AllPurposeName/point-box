require 'test_helper'

class PointsCreationAndViewingTest < ActionController::TestCase
  include Capybara::DSL
  attr_reader:user
  attr_reader:admin

  def setup
    @user = User.first
    @admin = User.last
  end

  test "a logged in user can view their points" do
    login_user
    visit '/users/1'
    assert page.has_content?("You have 3 points")
  end

  test "a user cannot access admin's options in points section" do
    login_user
    visit '/users/1'
    click_link_or_button("Back to All Users")

    assert page.has_content?("DJ")
    assert page.has_content?("You have 3 points")
    refute page.has_content?("Kaitryn")
  end

  test "an admin can view all users and their corresponding points" do
    login_admin
    visit '/users'
     assert page.has_content?("Points")
     assert page.has_content?("DJ")
     assert page.has_content?("3")
     assert page.has_content?("Kaitryn")
     assert page.has_content?("1")
  end

  test "an admin can add and destroy points" do
    login_admin
    visit '/users/1/edit'
    assert_equal 3, User.first.points.count
    click_link_or_button("Add a Point")
    assert_equal 4, User.first.points.count
    click_link_or_button("Destroy a Point")
    assert_equal 3, User.first.points.count

    # # which functionality is better?
    # click_link_or_button("Edit-DJ")
    # assert_equal 3, User.first.points.count
    # fill_in "Add points", with: "3"
    # click_link_or_button("Submit")
    # assert_equal 6, User.first.points.count
    #
    # click_link_or_button("Edit-DJ")
    # fill_in "Delete points", with: "5"
    # click_link_or_button("Submit")
    # assert_equal 1, User.first.points.count
  end
  # # DO I even want this functionality?
  # test "an admin can edit a users points" do
  #   login_admin
  #   visit '/users'
  #   click_link_or_button("Edit")
  #   assert_equal 3, User.first.points.all.where(status: false)
  #   fill_in "Redeem", with: "2"
  #   click_link_or_button("Submit")
  #   assert_equal 1, User.first.points.all.where(status: false)
  #   assert_equal 2, User.first.points.all.where(status: true)
  #
  #   click_link_or_button("Edit-DJ")
  #   fill_in "UnRedeem", with: "1"
  #   click_link_or_button("Submit")
  #   assert_equal 2, User.first.points.all.where(status: false)
  # end
end
