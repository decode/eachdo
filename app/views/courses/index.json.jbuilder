json.array!(@courses) do |course|
  json.extract! course, :id, :cid, :name, :description
  json.url course_url(course, format: :json)
end
