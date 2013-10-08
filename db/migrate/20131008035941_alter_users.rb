class AlterUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :name
      t.remove :location
      t.remove :website
      t.remove :bio
      t.remove :photo
      t.column :password_digest, :string,:null=>false
    end
  end
end
