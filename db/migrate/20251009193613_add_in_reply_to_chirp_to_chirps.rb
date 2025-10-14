class AddInReplyToChirpToChirps < ActiveRecord::Migration[8.0]
  def change
    add_reference :chirps, :in_reply_to_chirp, foreign_key: { to_table: :chirps }
  end
end
