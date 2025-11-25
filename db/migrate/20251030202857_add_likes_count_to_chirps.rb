class AddLikesCountToChirps < ActiveRecord::Migration[8.0]
  def change
    add_column :chirps, :likes_count, :integer, default: 0
  end
end
