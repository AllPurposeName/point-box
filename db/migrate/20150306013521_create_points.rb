class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :value, default: 1
      t.boolean :status, default: false
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :points, :users
  end
end
