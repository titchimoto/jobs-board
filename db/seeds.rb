require 'faker'

25.times do
  User.create!(username: Faker::Internet.unique.user_name, email: Faker::Internet.unique.email, password: "password", role: rand(0..2))
end

users = User.all


50.times do
  Job.create!(title: Faker::Lorem.unique.sentence(2), location: Faker::Address.city, body: Faker::Lorem.paragraph(5), user: users.sample)
end

jobs = Job.all

100.times do
  Favorite.create!(user: users.sample, job: jobs.sample)
end

100.times do
  Candidate.create!(body: Faker::Lorem.sentence(2), job: jobs.sample, user: users.sample)
end

me = User.create!(username: "Theo", email: "theo@meowmeowmeow.com", password: "password")




puts "Seed Finished"
puts "#{User.count} users created."
puts "#{Job.count} job listings created."
puts "#{Candidate.count} job candidates created."
puts "#{Favorite.count} job favorites created."
