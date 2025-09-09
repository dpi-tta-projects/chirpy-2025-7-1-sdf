# == Schema Information
#
# Table name: chirps
#
#  id         :bigint           not null, primary key
#  body       :text
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_chirps_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Chirp < ApplicationRecord
  belongs_to :user
end
