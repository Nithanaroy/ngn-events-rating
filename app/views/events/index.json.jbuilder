json.array!(@events) do |event|
  json.extract! event, :name, :details, :place, :from, :to, :going
  json.url event_url(event, format: :json)
end
