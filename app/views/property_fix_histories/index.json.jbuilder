json.array!(@property_fix_histories) do |property_fix_history|
  json.extract! property_fix_history, :id
  json.url property_fix_history_url(property_fix_history, format: :json)
end
