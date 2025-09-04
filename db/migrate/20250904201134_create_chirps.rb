class CreateChirps < ActiveRecord::Migration[8.0]
  def change
    create_table :chirps do |t|
      t.references :user, null: false, foreign_key: true
      t.text :body
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
