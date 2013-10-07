class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
        t.string :handle, :null => false
        t.string :name , :null => false
        t.string :location
        t.string :website
        t.string :bio
        t.string :photo
        t.integer :lock_version, :default => 0
        t.timestamps
        t.index :handle, :unique=>true
    end
  end
end
