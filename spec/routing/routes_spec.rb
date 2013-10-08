require 'spec_helper'

describe "Sign Up" do
  it "routes to user#create" do
     {:post => "/signup"}.should route_to(:controller => 'users',:action=>'create')
     {:get => "/signup"}.should_not be_routable
  end
end