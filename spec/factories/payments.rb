# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    order { nil }
    state { 'pending' }
  end
end
