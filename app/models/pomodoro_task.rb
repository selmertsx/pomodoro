# == Schema Information
#
# Table name: pomodoro_tasks
#
#  id         :bigint(8)        not null, primary key
#  objective  :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PomodoroTask < ApplicationRecord
  validates :objective, presence: true

  belongs_to :user
  has_many :pomodoro_memos
end
