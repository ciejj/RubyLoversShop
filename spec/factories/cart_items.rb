# frozen_string_literal: true

FactoryBot.define do
  factory :cart_item do
    product
    user
    quantity { 1 }
  end
end
