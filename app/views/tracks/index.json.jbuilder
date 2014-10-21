json.array!(@tracks) do |track|
  json.extract! track, :id, :distance, :name, :event
  json.url track_url(track, format: :json)
end
