FactoryBot.define do
  factory :product do
    name { 'The Thing' }
    price { 100 }
    brand
    category
  end
end
