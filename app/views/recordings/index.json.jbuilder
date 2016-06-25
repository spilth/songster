json.array!(@recordings) do |recording|
  json.extract! recording, :id, :name, :url, :description, :song_id
  json.url recording_url(recording, format: :json)
end
