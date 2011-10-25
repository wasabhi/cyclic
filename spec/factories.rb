FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :account do
    name { Faker::Name.name }
  end

  factory :user do
    email { Factory.next :email }
    name { Faker::Name.name }
    password 'password'
    password_confirmation { |u| u.password }
    
    after_create { |u| u.confirm! }
    account
  end
end
