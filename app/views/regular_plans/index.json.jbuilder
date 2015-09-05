json.array!(@regular_plans) do |regular_plan|
  json.extract! regular_plan, :id, :user_id, :category, :amount, :start_date, :interval
  json.url regular_plan_url(regular_plan, format: :json)
end
