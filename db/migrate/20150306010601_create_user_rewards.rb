class CreateUserRewards < ActiveRecord::Migration
  def change
    create_table :user_rewards do |t|
      t.references :user, index: true
      t.references :reward, index: true

      t.timestamps null: false
    end
    add_foreign_key :user_rewards, :users
    add_foreign_key :user_rewards, :rewards
  end
end
