json.array!(@teams) do |team|
  json.extract! team, :id, :tid, :name, :grade, :description
  json.url team_url(team, format: :json)
end
