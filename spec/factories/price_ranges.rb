# frozen_string_literal: true

FactoryBot.define do
  factory :price_range do
    min { 10 }
    max { 20 }
  end
end
