require 'faker'

25.times do
  User.create!(username: Faker::Internet.unique.user_name, email: Faker::Internet.unique.email, password: "password", role: rand(0..2))
end

users = User.all


50.times do
  Job.create!(title: Faker::Lorem.unique.sentence(2), location: Faker::Address.city, body: Faker::Lorem.paragraph(5), user: users.sample)
end

me = User.create!(username: "Theo", email: "theo@meowmeowmeow.com", password: "password")




puts "Seed Finished"
puts "#{User.count} users created"
puts "#{Job.count} job listings created"
