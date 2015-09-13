json.array!(@tasks) do |task|
  json.extract! task, :id, :title, :status, :position, :description, :course_id, :user_id
  json.url task_url(task, format: :json)
end
