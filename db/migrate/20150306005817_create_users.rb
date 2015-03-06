class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :name
      t.references :role, index: true
      t.text :password_digest

      t.timestamps null: false
    end
    add_foreign_key :users, :roles
  end
end
