json.array!(@houses) do |house|
  json.extract! house, :id, :identifier, :name, :address, :house_type, :area, :floor, :floor_type, :capacity, :bed, :direction, :status, :user_id
  json.url house_url(house, format: :json)
end
