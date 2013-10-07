class CreateFollowTable < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :user_id
      t.integer :follower_id
      t.integer :lock_version
      t.timestamps
    end

  end
end