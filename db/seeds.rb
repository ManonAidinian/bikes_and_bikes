# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'open-uri'

Review.destroy_all
Booking.destroy_all
Bike.destroy_all
User.destroy_all

i = 0
10.times do
  i += 1
  user = User.new(
    email: "#{Faker::Name.first_name.downcase}_#{Faker::Name.last_name.downcase}_#{i}@gmail.com",
    password: "123123",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
  avatar_picture = URI.open('https://loremflickr.com/100/100/human')
  p "Downloading random picture for a person"
  user.avatar_picture.attach(io: avatar_picture, filename: "#{user.first_name}_#{user.last_name}.png", content_type: 'image/png')
  user.save!
  # adding user's bikes:
  rand(6).times do
    bike = Bike.new(
      maker: ['Yamaha', 'Kawasaki', 'Honda', 'Gesits', 'Suzuki', 'Harley Davidson', 'Triumph'].sample,
      model: %w[C D F G H J K M N P Q R T V W X Y Z].sample(3).join + rand(1..6).to_s + rand(10).to_s + %w{0 5}.sample,
      category: Bike::CATEGORIES.sample,
      location: "#{Faker::Address.city}, #{Faker::Address.country}",
      latitude: Faker::Address.latitude,
      longitude: Faker::Address.longitude,
      year: rand(1900..2022),
      mileage: rand(500_000),
      available: (rand(2) == 1),
      daily_price: rand(20_000..1_000_000),
      description: "The best #{Bike::CATEGORIES.sample} you can get for money. Chuck Norris has this bike, that's why #{Faker::ChuckNorris.fact}",
      user: user
    )
    p "|—— Adding random pictures for a bike"
    rand(1..6).times do
      bike_picture = URI.open('https://loremflickr.com/300/200/motorbike')
      bike.pictures.attach(io: bike_picture, filename: "#{bike.maker}_#{bike.model}.png", content_type: 'image/png')
      p "   |—— Downloading picture for a bike"
    end
    # picture = Cloudinary::Uploader.upload('https://loremflickr.com/300/200/motorbike')
    bike.save!
  end
end

# for each bike we create 0-3 bookings with one review
Bike.all.each do |bike|
  rand(4).times do
    start_date = Faker::Date.backward(days: 20)
    end_date = Faker::Date.between(from: start_date, to: Faker::Date.forward(days: 20))
    booking = Booking.create!(
      bike: bike,
      user: User.where("id != #{bike.user_id}").sample,
      start_date: start_date,
      end_date: end_date,
      status: Booking::STATUSES.sample,
      total_price: (end_date - start_date) * bike.daily_price
    )
    Review.create!(
      comment: Faker::Restaurant.review.gsub(/(food|dish)/i, "bike").gsub(/(restaurant|place|cafe)/i, booking.user.first_name),
      booking: booking,
      booking_rating: rand(11),
      owner_rating: rand(11),
      bike_rating: rand(11)
    )
  end
end
