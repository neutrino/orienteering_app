json.array!(@events) do |event|
  json.extract! event, :id, :name, :location, :start_date, :end_date, :starting_point
  json.url event_url(event, format: :json)
end
