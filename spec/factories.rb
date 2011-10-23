FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email { Factory.next :email }
    password 'password'
    password_confirmation { |u| u.password }
    
    after_create { |u| u.confirm! }
  end
end
