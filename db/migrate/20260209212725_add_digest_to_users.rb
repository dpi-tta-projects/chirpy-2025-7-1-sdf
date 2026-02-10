class AddDigestToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :digest, :json
  end
end
