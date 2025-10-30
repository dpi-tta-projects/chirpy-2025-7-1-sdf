class CreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.references :chirp, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.index [ :user_id, :chirp_id ], unique: true

      t.timestamps
    end
  end
end
