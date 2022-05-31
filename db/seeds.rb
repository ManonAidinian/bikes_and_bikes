# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

User.destroy_all
Bike.destroy_all
i = 0
10.times do
  i += 1
  user = User.new(email: "#{Faker::Name.first_name.downcase}_#{Faker::Name.last_name.downcase}_#{i}@gmail.com", password: "123123", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
  user.save
  # adding user bikes:
  rand(6).times do
    bike = Bike.create(
      maker: ['Yamaha', 'Kawasaki', 'Honda', 'Gesits', 'Suzuki', 'Harley Davidson', 'Triumph'].sample,
      model: %w[C D F G H J K M N P Q R T V W X Y Z].sample(3).join + rand(1..6).to_s + rand(10).to_s + %w{0 5}.sample,
      category: Bike::CATEGORY.sample,
      location: "#{Faker::Address.city}, #{Faker::Address.country}",
      latitude: Faker::Address.latitude,
      longitude: Faker::Address.longitude,
      year: rand(1900..2022),
      mileage: rand(500000),
      available: (rand(2) == 1),
      daily_price: rand(20000..1000000),
      description: "The best #{Bike::CATEGORY.sample} you can get for money. Chuck Norris has this bike, that's why #{Faker::ChuckNorris.fact}",
      user: user
    )
    p bike.valid?
    p bike.save!
    p bike
  end
end
