unless Rails.env.production?
  namespace :dev do
    desc "Add sample data"
    task sample_data: :environment do

      puts "-- Adding sample data --"

      puts "-- Adding users --"

      names = [
        "alice",
        "bob",
        "carol",
        "dan",
        "ellen",
        "fred",
        "greta"
      ]

      names.each do |name|
        user = User.find_or_create_by(email_address: "#{name}@example.com") do |u|
          puts "-- Adding user: #{u.email_address} --"
          # TODO: handle downcase w/ normalization
          u.username = name
          u.bio = Faker::TvShows::Spongebob.quote
          u.location = Faker::Nation.capital_city
          u.display_name = name.capitalize

          u.password = "password"
        end
      end

      puts "-- Adding chirps --"

      100.times do
        name = names.sample
        email_address = "#{name}@example.com"
        user = User.find_by(email_address: email_address)

        chirp = Chirp.find_or_create_by(body: Faker::TvShows::Spongebob.quote) do |c|
          c.user = user
        end
      end

      puts "-- Done --"
    end

  end
end
