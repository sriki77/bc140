require 'spec_helper'

describe UsersController do

  context "When Insufficient information" do

    it "should return 400 for missing user" do
      post :create
      response.response_code.should==400
    end

    it "should return 403 for missing user handle" do
      post :create, {:user => {}}
      response.response_code.should==403
      res=JSON.parse(response.body)
      res['handle'].should_not be_nil
    end

    it "should return 403 for missing user password" do
      post :create, {:user => {:handle => 'cooker'}}
      response.response_code.should==403
      res=JSON.parse(response.body)
      res['handle'].should be_nil
      res['password'].should_not be_nil
    end
  end

  context "When input is invalid" do

    it "should return 403 if user handle length is invalid" do
      post :create, {:user => {:handle => 'c', :password => 'p', :password_confirmation => 'p'}}
      response.response_code.should==403
      res=JSON.parse(response.body)
      res['handle'].should_not be_nil
      post :create, {:user => {:handle => 'c_b_c', :password => 'p', :password_confirmation => 'p'}}
      response.response_code.should==403
      res=JSON.parse(response.body)
      res['handle'].should_not be_nil
    end

    it "should return 403 if user exits" do
      user = FactoryGirl.create(:user)
      post :create, {:user => {:handle => user.handle, :password => user.password, :password_confirmation => user.password_confirmation}}
      response.response_code.should==403
      res=JSON.parse(response.body)
      res['handle'].should_not be_nil
      res['password'].should be_nil
      res['password_confirmation'].should be_nil
    end
  end

  context "When new valid user" do
    it "Should create the user" do
      user = FactoryGirl.build(:user)
      post :create, {:user => {:handle => user.handle, :password => user.password, :password_confirmation => user.password_confirmation}}
      response.response_code.should==200
      response.body.should == user.handle
    end
  end

  context "Followers & Following" do
    it "Should list followers of the user" do
      user = FactoryGirl.create(:user_with_follows)
      session[:user_id]=user.id
      get :followers
      response.response_code.should==200
      res=JSON.parse(response.body)
      res.length.should == 5
    end
    it "Should list following of the user" do
      user = FactoryGirl.create(:user_with_follows)
      session[:user_id]=user.id
      get :following
      response.response_code.should==200
      res=JSON.parse(response.body)
      res.length.should == 5
      res[0]['handle'].start_with?('toBeCooked').should be_true
    end
    it "Should follow a given user" do
      user = FactoryGirl.create(:user)
      follow = FactoryGirl.create(:user_to_be_followed)
      session[:user_id]=user.id
      get :following
      response.response_code.should==200
      res=JSON.parse(response.body)
      res.length.should ==0
      post :follow, {:handle => follow.handle}
      response.response_code.should==200
      get :following
      response.response_code.should==200
      res=JSON.parse(response.body)
      res.length.should ==1
      res[0]['handle'].should == follow.handle
      follow.followers.length.should == 1
      follow.followers[0].handle == user.handle
    end
    it "Should unfollow a given user" do
      user = FactoryGirl.create(:user)
      follow = FactoryGirl.create(:user_to_be_followed)
      follow.followers<<user
      session[:user_id]=user.id
      get :following
      response.response_code.should==200
      res=JSON.parse(response.body)
      res.length.should ==1
      res[0]['handle'].should == follow.handle
      post :unfollow, {:handle => follow.handle}
      response.response_code.should==200
      logged_in = assigns[:current_user]
      logged_in.following.length.should == 0
    end
  end
end