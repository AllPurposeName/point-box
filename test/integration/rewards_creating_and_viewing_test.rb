require 'test_helper'
require 'Mocha'
class RewardsCreationAndViewingTest < ActionController::TestCase
  include Capybara::DSL
  attr_reader:user
  attr_reader:admin

  def setup
    @user = User.first
    @admin = User.last
  end

  test "a logged in user can view their rewards" do
    login_user
    visit '/users/1'
    assert page.has_content?("Rewards:")
  end

  test "an admin can view all users and their corresponding rewards" do
    login_admin
    visit '/rewards'
     assert page.has_content?("Create Reward")
     assert page.has_content?("DJ")
     assert page.has_content?("Kaitryn")
  end

  test "an admin can create rewards" do
    skip
    login_admin
    assert_equal 1, Reward.count
    click_link_or_button("Rewards")
    click_link_or_button("Create Reward")
    fill_in "Reward Name", with: "'Stache"
    fill_in "Reward Value", with: "2"
    click_link_or_button("Submit")
    assert_equal 2, Reward.count
    assert_equal '/rewards', current_path
    assert page.has_content?("'Stache")
  end

  test "an admin can edit a reward" do
    skip
    login_admin
    visit '/rewards'
    click_link_or_button("Black-Ball")
    assert_equal '/rewards/1', current_path
    assert page.has_content?("Cost: 1")
    click_link_or_button("Edit")
    fill_in "Reward Name", with: "Blackish-Ball"
    fill_in "Reward Cost", with: "2"
    click_link_or_button("Submit")

    assert_equal '/rewards/1', current_path
    assert page.has_content?("Cost: 2")
    assert page.has_content?("Blackish-Ball")
  end

  test "an admin can destroy a reward" do
    skip
    login_admin
    visit '/rewards'
    assert_equal 1, Reward.count
    click_link_or_button("Black-Ball")
    click_link_or_button("Delete")
    assert_equal 0, Reward.count
  end
end
