json.array!(@tracks) do |track|
  json.extract! track, :id, :distance, :name, :event
  json.url event_track_url(track.event, track, format: :json)
end
