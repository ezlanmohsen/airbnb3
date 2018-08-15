# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Seed Users
user = {}
user['password'] = 'test123'

ActiveRecord::Base.transaction do
  20.times do 
    user['first_name'] = Faker::Name.first_name 
    user['last_name'] = Faker::Name.last_name
    user['email'] = Faker::Internet.email
    user['birthdate'] = Faker::Date.between(50.years.ago, Date.today)

    User.create(user)
  end
end 


Tag.create(name: 'Pet Friendly')
Tag.create(name: 'Entire Dwelling')
Tag.create(name: 'Close to MRT')
Tag.create(name: 'Pool')
Tag.create(name: 'Gym')
Tag.create(name: 'Wifi')
Tag.create(name: 'Ensuite Bathroom')


# Seed Listings
listing = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  40.times do 
    listing['user_id'] = uids.sample
    listing['name'] = Faker::App.name
    listing['description'] = Faker::Hipster.sentence
    listing['address_1'] = Faker::Address.building_number
    listing['address_2'] = Faker::Address.street_address
    listing['postcode'] = Faker::Address.zip_code
    listing['state'] = Faker::Address.state 
    listing['country'] = Faker::Address.country
    listing['bedroom'] = Faker::Number.between(1, 5)
    listing['bed'] = Faker::Number.between(1, 5)
    listing['bathroom'] = Faker::Number.between(1, 3)
    listing['space'] = ["Living Room", "TV area", "Kitchen", "Gaming Area", "Balcony", "Other"].sample
    listing['max_guest'] = Faker::Number.between(2, 10)
    listing['max_price'] = rand(800..2500)
    listing['min_price'] = rand(100..1000)

    Listing.create(listing)
  end
end


# See taggings
tagging = {}
tids = []
Tag.all.each { |t| tids << t.id }

ActiveRecord::Base.transaction do
Listing.all.each do |l|
  rand(2..4).times do
    tagging['listing_id'] = l.id
    tagging['tag_id'] = tids.sample
    ListingTag.create(tagging)
  end
end

end

