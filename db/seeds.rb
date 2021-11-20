# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = FactoryBot.create(:admin)
admin2 = FactoryBot.create(:admin)

client = FactoryBot.create(:client)
client2 = FactoryBot.create(:client)

streamer = FactoryBot.create(:streamer)
streamer2 = FactoryBot.create(:streamer)
streamer3 = FactoryBot.create(:streamer)

streamer_profile = FactoryBot.create(:streamer_profile, streamer: streamer)
streamer_profile2 = FactoryBot.create(:streamer_profile, streamer: streamer2)