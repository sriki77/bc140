class Tweet < ActiveRecord::Base
  validates_presence_of :msg
  validates_length_of :msg, :within => 1..140
  belongs_to :user

  def as_json(options)
    super(:only=>[:id,:msg,:converse,:targeted])
  end
end
