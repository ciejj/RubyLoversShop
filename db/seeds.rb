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

puts 'generating Products'
Product.destroy_all
20.times do 
  p = Product.create(
      name: Faker::Commerce.unique.product_name,
      price: Faker::Number.decimal(l_digits: 2),
      category: Category.all.sample,
      brand: Brand.all.sample
  )
  puts "generating - product - #{p.name}"
  downloaded_image = URI.open("https://source.unsplash.com/700x400/?#{p.name.split.last}")
  p.main_image.attach(io: downloaded_image, filename: "mi_#{p.id}.png")
end

puts 'generating Orders'
Order.destroy_all
25.times do
  Order.create(state: rand(1..3), user: User.all.sample)
  Payment.create(order: Order.last)
  rand(5).times {|x| OrderItem.create(order: Order.last, product: Product.all.sample)}
end

