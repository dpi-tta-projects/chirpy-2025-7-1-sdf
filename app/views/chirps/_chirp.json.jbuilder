json.extract! chirp, :id, :user_id, :body, :deleted_at, :created_at, :updated_at
json.url chirp_url(chirp, format: :json)
