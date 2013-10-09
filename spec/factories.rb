require 'factory_girl'

FactoryGirl.define do
  factory :user do
    handle "Hawkins"
    password  "abc123"
    password_confirmation "abc123"
  end

  factory :user_with_profile, class: User do
    handle "Hawkins"
    password  "abc123"
    password_confirmation "abc123"
    profile
  end


  factory :profile do
    name "Hawkins Pressure Cooker"
    location  "Bangalore"
    website "www.hawkins.in"
    bio "Pressure Cooker"
    photo "/abc/hawkins.png"
  end

  factory :profile_different_name, class: Profile do
    name "Pigeon Pressure Cooker"
    location  "Bangalore"
    website "www.hawkins.in"
    bio "Pressure Cooker"
    photo "/abc/hawkins.png"
  end
end