class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :name
      t.integer :role
      t.text :password_digest

      t.timestamps null: false
    end
  end
end
