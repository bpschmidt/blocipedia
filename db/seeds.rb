# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require "faker"

  25.times do
    User.create!(
      email: Faker::Internet.email,
      password: "password",
      password_confirmation: "password"

    )
  end

  users = User.all

  100.times do
    Wiki.create!(
      title: Faker::Company.buzzword,
      body: Faker::StarWars.quote,
      user_id: User.all.sample.id
    )
  end

 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Wiki.count} wikis created"
