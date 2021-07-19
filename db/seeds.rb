Administrator.create_with(password: 'password').find_or_create_by(email: 'admin@example')
User.create_with(password: 'password').find_or_create_by(email: 'user@example')

puts 'generating Users'

3.times do |i|
  User.create_with(password: 'password').find_or_create_by(email: "user_#{i+1}@example")
end


puts 'generating Categories'

Category.destroy_all
4.times do
  Category.create(
    name: Faker::Commerce.unique.department(max: 1)
  )
end

puts 'generating Brands'

Brand.destroy_all
4.times do
  Brand.create(
    name: Faker::Device.unique.manufacturer
  )
end

categories = Category.all
brands = Brand.all

Product.destroy_all
15.times do 
  p = Product.create(
      name: Faker::Commerce.unique.product_name,
      price: Faker::Number.decimal(l_digits: 2),
      category: categories[rand(4)],
      brand: brands[rand(4)]
  )
  puts "generating - product - #{p.name}"
  downloaded_image = URI.open("https://source.unsplash.com/700x400/?#{p.name.split.last}")
  p.main_image.attach(io: downloaded_image, filename: "mi_#{p.id}.png")
end


users = User.all

puts 'generating Orders'

Order.destroy_all
15.times do
  Order.create(state: rand(1..3), user: users[rand(4)])
end

