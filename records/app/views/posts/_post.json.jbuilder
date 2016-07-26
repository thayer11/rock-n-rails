json.extract! post, :id, :title, :artist, :string, :year, :integer, :conver_art, :string, :song_count, :integer, :created_at, :updated_at
json.url post_url(post, format: :json)