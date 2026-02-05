class FavoriteUserJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "Finding favorite user..."

    # TODO: optimize
    user_id_likes_count_hash = Like.group(:user_id).count
    favorite_user_id = user_id_likes_count_hash.key(user_id_likes_count_hash.values.max)
    favorite_user = User.find_by(id: favorite_user_id)

    puts "#{favorite_user.username} is our favorite user"
    puts "#{favorite_user.username} has liked #{favorite_user.likes.count} chirps"
    puts "done"
  end
end
