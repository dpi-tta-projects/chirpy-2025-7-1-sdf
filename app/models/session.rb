# == Schema Information
#
# Table name: sessions
#
#  id         :bigint           not null, primary key
#  ip_address :string
#  ip_stack   :jsonb
#  user_agent :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_sessions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Session < ApplicationRecord
  belongs_to :user

  # TODO: move to background job
  after_create :fetch_ip_stack

  def fetch_ip_stack
    lookup = IpStack.lookup(ip_address)
    update(ip_stack: lookup)
  end
end
