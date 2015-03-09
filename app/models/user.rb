class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_many :points
  has_many :user_rewards
  has_many :rewards, through: :user_rewards

  enum role: %w(default admin)
end
