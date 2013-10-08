class CreateTweetTargets < ActiveRecord::Migration
  def change
    create_table :tweet_targets do |t|
      t.integer :lock_version, :null=>false,:default=>0
      t.timestamps
      t.belongs_to(:user)
      t.belongs_to(:tweet)
    end
    execute('ALTER TABLE tweet_targets ADD CONSTRAINT tweet_targets_user_fk FOREIGN KEY (user_id) REFERENCES users (id) MATCH FULL;')
    execute('ALTER TABLE tweet_targets ADD CONSTRAINT tweet_targets_tweet_fk FOREIGN KEY (tweet_id) REFERENCES tweets (id) MATCH FULL;')
  end
end
