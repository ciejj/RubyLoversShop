Admin.destroy_all

Admin.create(
  email: "admin@admin.com"
  password: "password"
)

User.destroy_all

User.create(
  email: "john@example.com",
  password: "password"
)

Category.destroy_all

4.times do
  Category.create(
    name: Faker::Commerce.department(max: 1)
  )
end

Brand.destroy_all

4.times do
  Brand.create(
    name: Faker::Device.manufacturer
  )
end

categories = Category.all
brands = Brand.all

Product.destroy_all

15.times do 
  Product.create(
      name: Faker::Commerce.product_name,
      price: Faker::Number.decimal(l_digits: 2),
      category: categories[rand(4)],
      brand: brands[rand(4)]
  )
end