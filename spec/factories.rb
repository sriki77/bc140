require 'factory_girl'

FactoryGirl.define do
  factory :user do
    handle "Hawkins"
    password  "abc123"
    password_confirmation "abc123"
  end

end