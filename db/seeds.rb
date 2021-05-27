require 'faker'

Category.destroy_all

4.times do
  Category.create(
    name: Faker::Commerce.department(max: 1)
  )
end

categories = Category.all

Product.destroy_all

15.times do 
  Product.create(
      name: Faker::Commerce.product_name,
      price: Faker::Number.decimal(l_digits: 2),
      category: categories[rand(4)]
  )
end