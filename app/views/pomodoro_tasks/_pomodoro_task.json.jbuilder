json.extract! pomodoro_task, :id, :objective, :user_id, :created_at, :updated_at
json.url pomodoro_task_url(pomodoro_task, format: :json)
