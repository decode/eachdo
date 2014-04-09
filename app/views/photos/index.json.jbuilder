json.array!(@photos) do |photo|
  json.extract! photo, :id, :album_id, :title, :image, :description
  json.url photo_url(photo, format: :json)
end
