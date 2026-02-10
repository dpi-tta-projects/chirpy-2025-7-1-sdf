module User::Digestable
  extend ActiveSupport::Concern

  def refresh_digest
    chirps = Chirp.following_feed_for(self).limit(50)
    digest = DigestService.new(chirps:).call
    update(digest:)
  end

  class_methods do
    def refresh_digest
      # TODO: do in batches
      User.all.each do |user|
        user.refresh_digest
      end
    end
  end
end
