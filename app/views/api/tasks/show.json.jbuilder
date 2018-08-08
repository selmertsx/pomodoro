json.set! :task do
  json.extract! @task, :id, :name, :created_at, :updated_at
end
