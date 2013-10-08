require 'spec_helper'

describe "Sign Up" do
  it "routes to user#create" do
     {:post => "/signup"}.should route_to(:controller => 'users',:action=>'create')
     {:get => "/signup"}.should route_to(:controller => 'errors',:action=>'routing',:a=>'signup')
  end
end

describe "Login & Logout" do
  it "routes to user#create" do
    {:post => "/login"}.should route_to("sessions#create")
    {:post => "/logout"}.should route_to("sessions#destroy")
  end
end