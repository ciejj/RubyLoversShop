# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    addressable { nil }
    street_name1 { 'Sesame Street' }
    street_name2 { '12345' }
    city { 'New York' }
    country { 'USA' }
    state { 'NY' }
    zip { '12-345' }
    phone { '600 100 200' }
  end
end
