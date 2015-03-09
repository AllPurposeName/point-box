require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user cannot be created with out all fields valid" do
    user1 = User.new(name: "Derek")
    refute user1.save

    user2 = User.new(password_digest: "pw")
    refute user2.save
  end

  test "no two users can have the same name" do
    user1 = User.new(name: "Derek", password_digest: "pw")
    user2 = User.new(name: "Derek", password_digest: "pw1")

    user1.save
    refute user2.save
  end
end
