# frozen_string_literal: true

FactoryBot.define do
  factory :administrator do
    sequence(:email) { |n| "admin_no_#{n}@example.com" }
    password { 'password' }
  end
end
