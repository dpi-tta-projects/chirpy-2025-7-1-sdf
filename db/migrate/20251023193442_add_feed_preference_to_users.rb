class AddFeedPreferenceToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :feed_preference, :string, null: false, default: "for_you"
  end
end
