class TweetSerializer < ActiveModel::Serializer
  attributes :id, :msg, :converse, :targeted, :user
  def user
    object.user.handle
  end
end