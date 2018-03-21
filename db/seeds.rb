require 'faker'

25.times do
  User.create!(username: Faker::Internet.unique.user_name, email: Faker::Internet.unique.email, password: "password")
end


50.times do
  Job.create!(title: Faker::Lorem.unique.sentence(2), location: Faker::Address.city, body: Faker::Lorem.paragraph)
end

me = User.create!(username: "Theo", email: "theo@meowmeowmeow.com", password: "password")




puts "Seed Finished"
puts "#{User.count} users created"
puts "#{Job.count} job listings created"
