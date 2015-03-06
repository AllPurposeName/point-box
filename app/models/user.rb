class User < ActiveRecord::Base
  belongs_to :role
  has_many :user_rewards
  has_many :rewards, through: :user_rewards
end
