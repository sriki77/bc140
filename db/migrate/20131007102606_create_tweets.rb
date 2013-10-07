class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :msg, :limit => 140
      t.integer :lock_version
      t.string :converse
      t.timestamps
      t.belongs_to(:user)
    end
  end
end
