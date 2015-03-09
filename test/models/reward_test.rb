require 'test_helper'

class RewardTest < ActiveSupport::TestCase
  test "reward cannot be created with out all fields valid" do
    reward1 = Reward.new(name: "Derek's hat")
    refute reward1.save

    reward2 = Reward.new(cost: 3)
    refute reward2.save
  end

  test "no two rewards can have the same name" do
    reward1 = Reward.new(name: "Derek's hat", cost: 2)
    reward2 = Reward.new(name: "Derek's hat", cost: 3)

    reward1.save
    refute reward2.save
  end
end
