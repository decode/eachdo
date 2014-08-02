json.array!(@feedbacks) do |feedback|
  json.extract! feedback, :id, :house_id, :order_id, :title, :comment, :rating, :judgement
  json.url feedback_url(feedback, format: :json)
end
