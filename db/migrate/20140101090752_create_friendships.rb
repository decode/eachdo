class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.references :user
      t.integer :friend_id
      t.string :status
      t.time :accepted_at
      t.timestamps
    end
  end
end
