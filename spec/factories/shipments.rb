# frozen_string_literal: true

FactoryBot.define do
  factory :shipment do
    order { nil }
    state { 'pending' }
  end
end
