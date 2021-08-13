# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    state { :new }
    user

    after(:create) do |order|
      create(:payment, order: order)
      create(:shipment, order: order)
      create(:order_item, order: order)
    end
  end
end
