require 'spec_helper'

describe ProfilesController do

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  it "should return profile of user" do
    user = FactoryGirl.create(:user_with_profile)
    profile = FactoryGirl.build(:profile)
    profile.user=user
    session[:user_id]=user.id
    get :show
    response.response_code.should==200
    profile.from_json(response.body).should be profile
  end

  it "should delete profile of user" do
    user = FactoryGirl.create(:user_with_profile)
    session[:user_id]=user.id
    current_user.profile.should_not be_nil
    post :destroy
    response.response_code.should==200
    current_user.profile.should be_nil
  end

  it "should create profile of user" do
    user = FactoryGirl.create(:user_with_profile)
    profile = FactoryGirl.build(:profile)
    session[:user_id]=user.id
    post :create, {:profile => FactoryGirl.attributes_for(:profile)}
    response.response_code.should==200
    response.body.should == profile.name
  end

  it "should update profile of user" do
    user = FactoryGirl.create(:user_with_profile)
    old_profile = FactoryGirl.build(:profile)
    profile = FactoryGirl.build(:profile_different_name)
    session[:user_id]=user.id
    current_user.profile.name.should == old_profile.name
    post :update, {:profile => FactoryGirl.attributes_for(:profile_different_name)}
    response.response_code.should==200
    response.body.should == profile.name
    current_user.profile.name.should == profile.name
  end

end