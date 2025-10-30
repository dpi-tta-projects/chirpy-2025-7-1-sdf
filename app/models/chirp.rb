# == Schema Information
#
# Table name: chirps
#
#  id                   :bigint           not null, primary key
#  body                 :text
#  deleted_at           :datetime
#  likes_count          :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  in_reply_to_chirp_id :bigint
#  user_id              :bigint           not null
#
# Indexes
#
#  index_chirps_on_in_reply_to_chirp_id  (in_reply_to_chirp_id)
#  index_chirps_on_user_id               (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (in_reply_to_chirp_id => chirps.id)
#  fk_rails_...  (user_id => users.id)
#
class Chirp < ApplicationRecord
  belongs_to :user

  belongs_to :parent_chirp, class_name: "Chirp", foreign_key: "in_reply_to_chirp_id", optional: true
  has_many :replies, class_name: "Chirp", foreign_key: "in_reply_to_chirp_id", dependent: :destroy
  has_many :likes, dependent: :destroy

  scope :originals, -> { where(in_reply_to_chirp_id: nil) }
  scope :replies, -> { where.not(in_reply_to_chirp_id: nil) }

  def title
    "#{user.display_name} on Chirpy: \"#{body.truncate_words(10)}\""
  end

  def self.following_feed_for(user)
    user_ids = user.following.pluck(:id)

    Chirp
      .where(user_id: user_ids + [ user.id ])
      .where(deleted_at: nil)
      .order(created_at: :desc)
  end
end
