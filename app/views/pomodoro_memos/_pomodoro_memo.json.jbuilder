json.extract! pomodoro_memo, :id, :memo, :pomodoro_task_id, :created_at, :updated_at
json.url pomodoro_memo_url(pomodoro_memo, format: :json)
