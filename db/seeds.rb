# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require "open-uri"
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
        5.times do
          usertest = User.create(
          email: Faker::Internet.email,
          password: "terteUset")
         # puts "User creation..."
         # puts usertest.usernamer
          usertest.save!
        end
        Stall.destroy_all
        10.times do
          stall = Stall.create(
          name: Faker::Restaurant.name,
          rating: rand(1..5),
          category: ["Tacos", "Quesadilla", "Burritos", "Chorizos", "Exotic"].sample,
          description: Faker::Quote.matz,
          address: Faker::Address.full_address
          )
         #stall.user = User.all.sample
          file = URI.open('https://www.intrepidtravel.com/adventures/wp-content/uploads/2018/05/shutterstock_761367214-800.png')
          stall.user = User.all.sample
          puts "Listing creation..."
          puts stall.name

          stall.photos.attach(io: file, filename: 'nes.png', content_type: 'image/png')
           stall.save!
          file.close
        end
        # attaching image:
