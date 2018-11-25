# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

3.times do
  messenger = Messenger.create(name: Faker::Pokemon.location)
  3.times do
    User.create(name: Faker::Pokemon.name, messenger: messenger, password: '1111')
  end
end