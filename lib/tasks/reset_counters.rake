namespace :reset_counters do

  desc "Resets counter cache for chirps"
  task chirps: :environment do
    puts("Resetting counter cache for all chirps...")
    Chirp.all.each do |chirp|
      Chirp.reset_counters(chirp.id, :likes)
    end
    puts "done"
  end
end
