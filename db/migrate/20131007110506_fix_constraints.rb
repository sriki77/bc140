class FixConstraints < ActiveRecord::Migration
  def change
    execute('ALTER TABLE tweets ADD CONSTRAINT tweets_user_fk FOREIGN KEY (user_id) REFERENCES users (id) MATCH FULL;')
    execute('ALTER TABLE follows ADD CONSTRAINT follows_user_fk FOREIGN KEY (user_id) REFERENCES users (id) MATCH FULL;')
    execute('ALTER TABLE follows ADD CONSTRAINT follows_follower_fk FOREIGN KEY (follower_id) REFERENCES users (id) MATCH FULL;')
  end
end
