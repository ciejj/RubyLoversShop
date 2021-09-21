# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "The Thing no #{n}" }
    price { 100 }
    description { 'The description' }
  end
end
