# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  bio             :text
#  display_name    :string
#  email_address   :string           not null
#  feed_preference :string           default("for_you"), not null
#  location        :string
#  password_digest :string           not null
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email_address  (email_address) UNIQUE
#  index_users_on_username       (username) UNIQUE
#
class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one :latest_session, -> { order(created_at: :desc) }, class_name: "Session"
  has_many :chirps
  has_many :likes
  has_many :liked_chirps, through: :likes, source: :chirp
  has_many :follows_as_follower, class_name: "Follow", foreign_key: :follower_id
  has_many :follows_as_following, class_name: "Follow", foreign_key: :following_id
  has_many :following, through: :follows_as_follower, source: :following
  has_many :followers, through: :follows_as_following, source: :follower

  normalizes :email_address, with: ->(email_address) { email_address.strip.downcase }

  validates :username, presence: true, uniqueness: true
  validates :display_name, presence: true

  enum :feed_preference, { for_you: "for_you", following: "following" }, suffix: true, default: "for_you"

  def is_following?(user)
    following.find_by(id: user.id).present?
  end
end
