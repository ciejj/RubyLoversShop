FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "john_no_#{n}@example.com" }
    password { 'password' }
  end
end
