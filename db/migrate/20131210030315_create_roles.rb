class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :restaurant_id
      t.integer :user_id

      t.timestamps
    end
  end
end
