json.array!(@task_scores) do |task_score|
  json.extract! task_score, :id, :score, :content, :user_id, :task_id
  json.url task_score_url(task_score, format: :json)
end
