class FixFollows < ActiveRecord::Migration
  def change
    change_table :follows do |t|
      t.change :user_id,:integer, :null=>false
      t.change :follower_id,:integer, :null=>false
      t.change :lock_version, :integer, :null => false, :default => 0
    end
  end
end
