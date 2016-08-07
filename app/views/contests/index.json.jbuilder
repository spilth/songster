json.array!(@contests) do |contest|
  json.extract! contest, :id, :name, :description, :url, :ends_at
  json.url contest_url(contest, format: :json)
end
