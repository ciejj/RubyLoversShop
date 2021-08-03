FactoryBot.define do
  factory :shipment do
    order { nil }
    state { 'pending' }
  end
end
