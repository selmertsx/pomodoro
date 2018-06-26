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

require 'test_helper'

class PomodoroMemoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
