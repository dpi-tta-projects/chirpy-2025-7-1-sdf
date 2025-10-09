# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  bio             :text
#  display_name    :string
#  email_address   :string           not null
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
  has_many :chirps

  normalizes :email_address, with: ->(email_address) { email_address.strip.downcase }

  validates :username, presence: true, uniqueness: true
  validates :display_name, presence: true
end
