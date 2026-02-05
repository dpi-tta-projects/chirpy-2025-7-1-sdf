class FavoriteUserJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "Finding favorite user..."

    # find user who has liked the most chirps
    favorite_user = User
      .joins(:likes)
      .group("users.id")
      .order("COUNT(likes.id) DESC")
      .limit(1)
      .first

    puts "#{favorite_user.username} is our favorite user"
    puts "#{favorite_user.username} has liked #{favorite_user.likes.count} chirps"
    puts "done"
  end
end
