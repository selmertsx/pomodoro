# == Schema Information
#
# Table name: pomodoro_memos
#
#  id               :bigint(8)        not null, primary key
#  memo             :text(65535)      not null
#  pomodoro_task_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class PomodoroMemo < ApplicationRecord
  validates :memo, presence :true

  belongs_to :pomodoro_task
end
