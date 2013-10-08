class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name , :null => false
      t.string :location
      t.string :website
      t.string :bio
      t.string :photo
      t.integer :lock_version, :default => 0
      t.timestamps
      t.belongs_to(:user)
    end
    execute('ALTER TABLE profiles ADD CONSTRAINT profiles_user_fk FOREIGN KEY (user_id) REFERENCES users (id) MATCH FULL;')
  end
end
