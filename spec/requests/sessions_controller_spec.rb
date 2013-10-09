require 'spec_helper'

describe "User Login" do
  before{
    user = FactoryGirl.build(:user)
    post "/signup" , {:user=>{:handle=>user.handle,:password=>user.password, :password_confirmation=>user.password_confirmation}}
  }
  context "When new valid user" do
    it "Should log in" do
      user = FactoryGirl.build(:user)
      post "/login" , {:handle=>user.handle,:password=>user.password}
      response.response_code.should==200
      response.body.should == user.handle
      session[:user_id].should_not be_nil
    end
    it "Should logout" do
      user = FactoryGirl.build(:user)
      post "/login" , {:handle=>user.handle,:password=>user.password}
      session[:user_id].should_not be_nil
      post "/logout"
      response.response_code.should==200
      session[:user_id].should be_nil
    end
  end
  context "When invalid user" do
    it "403 on login" do
      user = FactoryGirl.build(:user)
      post "/login" , {:handle=>user.handle}
      response.response_code.should==401
      response.body.should == user.handle
    end
    it "404 on logout" do
      post "/logout"
      response.response_code.should==404
    end
  end
end