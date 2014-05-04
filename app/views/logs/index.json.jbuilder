json.array!(@logs) do |log|
  json.extract! log, :id, :activity, :time_clocked_in, :time_clocked_out, :duration, :categories
  json.url logs_url(log, format: :json)
end
