# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { 'The Thing' }
    price { 100 }
  end
end
