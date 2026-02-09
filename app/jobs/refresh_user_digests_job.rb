class RefreshUserDigestsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.refresh_digest
  end
end
