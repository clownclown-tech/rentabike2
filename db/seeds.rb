 # This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Cleaning database..."

Booking.destroy_all
Bike.destroy_all
User.destroy_all

klaus = User.create(first_name: "Klaus", last_name: "Miau", email: "Klaus@gmail.com", password: "123456")
peter = User.create(first_name: "Peter", last_name: "Kleber", email: "Peter@gmail.com", password: "123456")

puts "Creating bikes..."

# The bike can´t be saved without user id, added it"
test_bike_1 = Bike.create!(name: "Cool e-bike", description: "very nice bike, bearly used because I have
  another one. It was a shame to have this one in my basement without use", model: "e-bike", location: "Berlin", year: 2021, price: 25.99, user_id: klaus.id)
puts "created #{test_bike_1.id}"

test_bike_2 = Bike.create!(name: "Stevens", description: "These are the tecnical details. The bike is for beginners and
  very easy to ride.", model: "XPF-8545", location: "Berlin-Spandau", year: 2015, price: 65.99, user_id: peter.id)
puts "created #{test_bike_2.id}"

test_bike_3 = Bike.create!(name: "Little bike", description: "Bike for children between 5 and 7 years. It is too
  small for my son. Everything is working and for the price I can offer a helmet on top", model: "childweels", location: "Berlin-Mitte", year: 2020, price: 40, user_id: klaus.id)
puts "created #{test_bike_3.id}"

booking_1 = Booking.create(start: Date.new(2022, 4, 3), end: Date.new(2022, 4, 6), user_id: peter.id, bike_id: test_bike_3.id)
puts "created #{booking_1.id}"

32.times do
  new_bike = Bike.create!(name: Faker::Name.name, description: Faker::Quote.matz, model: Faker::Vehicle.make, location: "Berlin", year: Faker::Vehicle.year, price: Faker::Number.decimal(l_digits: 1), user_id: peter.id)
  sample_file = Dir.glob("app/assets/images/bikes/*.jpg").sample
  puts sample_file
  new_bike.image.attach(io: File.open("#{sample_file}"), filename: "#{sample_file}", content_type: 'image/jpg')
end

puts "seed finished"
