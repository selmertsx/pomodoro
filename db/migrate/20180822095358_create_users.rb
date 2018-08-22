class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :sub, null: false
      t.string :preferred_username, null: false
      t.timestamps
    end

    add_index :users, :name
    add_index :users, :sub
    add_index :users, :preferred_username
  end
end
