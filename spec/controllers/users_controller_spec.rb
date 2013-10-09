require 'spec_helper'

describe UsersController do

  context "When Insufficient information" do

    it "should return 400 for missing user" do
      post :create
      response.response_code.should==400
    end

    it "should return 403 for missing user handle" do
      post :create , {:user => {}}
      response.response_code.should==403
      res=JSON.parse(response.body)
      res['handle'].should_not be_nil
    end

    it "should return 403 for missing user password" do
      post :create , {:user=>{:handle=>'cooker'}}
      response.response_code.should==403
      res=JSON.parse(response.body)
      res['handle'].should be_nil
      res['password'].should_not be_nil
    end
  end

  context "When input is invalid" do

    it "should return 403 if user handle length is invalid" do
      post :create , {:user=>{:handle=>'c'}}
      response.response_code.should==403
      res=JSON.parse(response.body)
      res['handle'].should_not be_nil
    end

    it "should return 403 if user exits" do
      user = FactoryGirl.create(:user)
      post :create , {:user=>{:handle=>user.handle,:password=>user.password, :password_confirmation=>user.password_confirmation}}
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
      post :create , {:user=>{:handle=>user.handle,:password=>user.password, :password_confirmation=>user.password_confirmation}}
      response.response_code.should==200
      response.body.should == user.handle
    end
  end
end