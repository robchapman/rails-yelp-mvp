# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Cleaning database..."
Restaurant.destroy_all

puts "Creating restaurants..."
Faker::Config.locale = 'en-AU'
10.times do
  name = Faker::Restaurant.name
  address = Faker::Address.street_address
  phone_number = Faker::PhoneNumber.phone_number_with_country_code
  category = Restaurant::CATEGORIES.sample
  restaurant = Restaurant.create!(name: name, address: address, phone_number: phone_number, category: category)
  rand(1..3).times do
    content = Faker::Restaurant.review
    rating = rand(0..5)
    review = Review.new(content: content, rating: rating)
    review.restaurant = restaurant
    review.save
  end
  puts "Created #{restaurant.name}"
end

puts "Finished!"
