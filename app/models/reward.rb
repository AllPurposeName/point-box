class Reward < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true
  validates :cost, presence: true

  has_many :user_rewards
  has_many :users, through: :user_rewards
end
