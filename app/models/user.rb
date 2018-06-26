class User < ApplicationRecord
  has_many :pomodoro_tasks, dependent: :destroy
end
