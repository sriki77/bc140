class User < ActiveRecord::Base
  validates_presence_of :handle
  validates_length_of :handle, :within => 3..20
  validates_uniqueness_of :handle
  has_secure_password
  has_one :profile, :dependent => :destroy
  has_many :tweets,:dependent => :destroy

  def as_json(options)
    super(:only=>[:handle])
  end
end
