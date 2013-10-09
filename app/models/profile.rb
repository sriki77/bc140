class Profile < ActiveRecord::Base
  belongs_to :user
  def as_json(options)
     super(:only=>[:name,:location,:website,:bio,:photo])
  end
end
