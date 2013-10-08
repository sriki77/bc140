class FixTweets < ActiveRecord::Migration
  def change
    change_table :tweets do |t|
      t.change :lock_version,:integer, :null=>false,:default=>0
      t.column :targeted, :boolean, :null=>false,:default=>false
    end
  end
end
