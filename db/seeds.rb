require 'cloudinary'
require 'cloudinary/uploader'
require 'cloudinary/utils'

# Ensure Cloudinary is properly configured before usage
Cloudinary.config do |config|
  config.cloud_name = ENV['CLOUDINARY_CLOUD_NAME']
  config.api_key = ENV['CLOUDINARY_API_KEY']
  config.api_secret = ENV['CLOUDINARY_API_SECRET']
end

BERLIN_STREETS = [
  "Berlin Alexanderplatz",
  "Berlin Kurfürstendamm",
  "Berlin Unter den Linden",
  "Berlin Friedrichstraße",
  "Berlin Potsdamer Platz",
  "Berlin Hackescher Markt",
  "Berlin Schönhauser Allee",
  "Berlin Wittenbergplatz",
  "Berlin Zoologischer Garten",
  "Berlin East Side Gallery",
  "Berlin Gendarmenmarkt",
  "Berlin Karl-Marx-Allee",
  "Berlin Schlossstraße",
  "Berlin Bertolt-Brecht-Platz",
  "Berlin Ernst-Reuter-Platz",
  "Berlin Lützowstraße",
  "Berlin Kaiser-Friedrich-Platz",
  "Berlin Königsallee",
  "Berlin Rosa-Luxemburg-Platz",
  "Berlin Strausberger Platz",
  "Berlin Mitte",
  "Berlin Warschauer Straße",
  "Berlin Alt-Berliner Straße",
  "Berlin Berliner Allee",
  "Berlin Grunewaldstraße",
  "Berlin Seestraße",
  "Berlin Bismarckstraße",
  "Berlin Fasanenstraße",
  "Berlin Hohenzollerndamm",
  "Berlin Wilhelmstraße",
  "Berlin Buchberger Straße",
  "Berlin Chausseestraße",
  "Berlin Eberswalder Straße",
  "Berlin Hauptstraße",
]


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

booking_1 = Booking.create(start: Date.new(2022, 4, 3), end: Date.new(2022, 4, 6), user_id: peter.id, bike_id: test_bike_1.id)
puts "created #{booking_1.id}"

32.times do
  new_bike = Bike.create!(name: Faker::Name.name, description: Faker::Quote.matz, model: Faker::Vehicle.make,  location: BERLIN_STREETS.sample, year: Faker::Vehicle.year, price: Faker::Number.decimal(l_digits: 1), user_id: peter.id)
  sample_file = Dir.glob("app/assets/images/bikes/*.jpg").sample
  puts sample_file
  new_bike.image.attach(io: File.open("#{sample_file}"), filename: "#{sample_file}", content_type: 'image/jpg')
end

puts "seed finished"
