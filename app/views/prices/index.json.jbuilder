json.array!(@prices) do |price|
  json.extract! price, :id, :house_id, :day, :week, :month, :weekend, :weekend_type
  json.url price_url(price, format: :json)
end
