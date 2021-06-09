FactoryBot.define do
  factory :admin do
    sequence(:email) { |n| "admin_no_#{n}@example.com" }
    password { 'password' }
  end
end
