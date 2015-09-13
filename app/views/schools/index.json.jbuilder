json.array!(@schools) do |school|
  json.extract! school, :id, :name, :description, :province, :city, :zipcode, :address
  json.url school_url(school, format: :json)
end
