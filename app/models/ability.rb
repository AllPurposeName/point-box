class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    reward = Reward.new
    can :read, User, id: user.id
    can :read, Reward
    # can :create, Reward
    if user.admin?
      can :manage, :all
    end
  end
end
