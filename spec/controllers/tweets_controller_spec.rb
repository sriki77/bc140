require 'spec_helper'

describe TweetsController do

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  it "should return tweets of user" do
    user = FactoryGirl.create(:user_with_tweets)
    session[:user_id]=user.id
    get :index
    response.response_code.should==200
    JSON.parse(response.body).should == JSON.parse(user.tweets.to_json)
  end

  it "should return given tweet of user" do
    user = FactoryGirl.create(:user_with_tweets)
    session[:user_id]=user.id
    get :show, {:id => user.tweets[1].id}
    response.response_code.should==200
    Tweet.new().from_json(response.body).should == user.tweets[1]
  end

  it "should create tweet for user" do
    user = FactoryGirl.create(:user_with_tweets)
    tweet = FactoryGirl.build(:cook_tweet)
    session[:user_id]=user.id
    post :create, {:tweet => FactoryGirl.attributes_for(:cook_tweet)}
    response.response_code.should==200
    t=Tweet.new().from_json(response.body)
    tweet.id=t.id
    t.should == tweet
  end

  it "should return tweets in sorted order for user" do
    user = FactoryGirl.create(:user)
    tweet = FactoryGirl.build(:cook_tweet)
    session[:user_id]=user.id
    post :create, {:tweet => {:msg=>"213"}}
    post :create, {:tweet => {:msg=>"132"}}
    post :create, {:tweet => {:msg=>"632"}}
    get :index
    response.response_code.should==200
    res=JSON.parse(response.body)
    res.length.should == 3
    res[0]['msg'].should == "213"
    res[1]['msg'].should == "132"
    res[2]['msg'].should == "632"
  end

  it "should delete tweet of user" do
    user = FactoryGirl.create(:user_with_tweets)
    session[:user_id]=user.id
    delete :destroy, {:id => user.tweets[-1].id}
    response.response_code.should==200
    current_user.tweets.length.should == user.tweets.length-1
    current_user.tweets.should == user.tweets[0..user.tweets.length-2]
  end

  it "should update tweet of user" do
    user = FactoryGirl.create(:user_with_tweets)
    tweet = FactoryGirl.build(:cook_tweet)
    tweet.id=user.tweets[0].id
    session[:user_id]=user.id
    current_user.tweets[0].msg.should_not == tweet.msg
    put :update, {:id=>tweet.id,:tweet => FactoryGirl.attributes_for(:cook_tweet)}
    response.response_code.should==200
    current_user.tweets[0].id.should == tweet.id
    current_user.tweets[0].msg.should == tweet.msg
  end

end