# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "-- Seeding database --"

puts "-- Adding Users --"

emails = [
  "ihera2@uillinois.edu",
  "brianhkim13@gmail.com"
]

emails.each do |email|
  puts "-- Adding #{email} --"
  User.find_or_create_by(email_address: email) do |u|
    u.password = SecureRandom.hex(8)
  end
end

puts "-- Done --"
