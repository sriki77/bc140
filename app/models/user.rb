class User < ActiveRecord::Base
  validates_presence_of :handle
  validates_length_of :handle, :within => 3..20
  validates_uniqueness_of :handle
  has_secure_password
  has_one :profile, :dependent => :destroy
  has_many :tweets, :dependent => :destroy
  has_and_belongs_to_many :followers,
                          :join_table => 'follows',
                          :foreign_key => 'user_id',
                          :association_foreign_key => 'follower_id',
                          :class_name => 'User'
  has_and_belongs_to_many :following,
                          :join_table => 'follows',
                          :foreign_key => 'follower_id',
                          :association_foreign_key => 'user_id',
                          :class_name => 'User'
  def as_json(options)
    super(:only => [:handle])
  end
end
