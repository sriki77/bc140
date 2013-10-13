require 'factory_girl'

FactoryGirl.define do
  factory :user do
    handle "Hawkins"
    password "abc123"
    password_confirmation "abc123"
  end

  factory :user_with_profile, class: User do
    handle "Hawkins"
    password "abc123"
    password_confirmation "abc123"
    profile
  end


  factory :profile do
    name "Hawkins Pressure Cooker"
    location "Bangalore"
    website "www.hawkins.in"
    bio "Pressure Cooker"
    photo "/abc/hawkins.png"
  end

  factory :profile_different_name, class: Profile do
    name "Pigeon Pressure Cooker"
    location "Bangalore"
    website "www.hawkins.in"
    bio "Pressure Cooker"
    photo "/abc/hawkins.png"
  end

  factory :user_with_tweets, class: User do
    handle "Hawkins"
    password "abc123"
    password_confirmation "abc123"
    after(:create) do |user|
      FactoryGirl.create_list(:tweet, 5, user: user)
    end
  end

  factory :tweet do
    msg "Whistle from Hawkins Pressure Cooker #{Time.now}"
    converse "xyz"
    targeted false

  end

  factory :cook_tweet, class: Tweet do
    msg "Cooked from Hawkins Pressure Cooker #{Time.now}"
    converse "abc"
    targeted true
  end

  factory :user_with_follows, class: User do
    handle "Prestige"
    password "abc123"
    password_confirmation "abc123"
    after(:create) do |user|
      FactoryGirl.create_list(:tweet, 5, user: user)
    end
    followers {
      f=[]
      (1..5).each do
        f<<FactoryGirl.create(:follower)
      end
      f
    }
    following {
      f=[]
      (1..5).each do
        f<<FactoryGirl.create(:following)
      end
      f
    }

  end

  factory :follower, class: User do
    sequence(:handle) { |n| "cooker#{n}" }
    password "abc123"
    password_confirmation "abc123"
  end

  factory :following, class: User do
    sequence(:handle) { |n| "toBeCooked#{n}" }
    password "abc123"
    password_confirmation "abc123"
  end

end