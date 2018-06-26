require 'test_helper'

class PomodoroTasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pomodoro_task = pomodoro_tasks(:one)
  end

  test "should get index" do
    get pomodoro_tasks_url
    assert_response :success
  end

  test "should get new" do
    get new_pomodoro_task_url
    assert_response :success
  end

  test "should create pomodoro_task" do
    assert_difference('PomodoroTask.count') do
      post pomodoro_tasks_url, params: { pomodoro_task: { objective: @pomodoro_task.objective, user_id: @pomodoro_task.user_id } }
    end

    assert_redirected_to pomodoro_task_url(PomodoroTask.last)
  end

  test "should show pomodoro_task" do
    get pomodoro_task_url(@pomodoro_task)
    assert_response :success
  end

  test "should get edit" do
    get edit_pomodoro_task_url(@pomodoro_task)
    assert_response :success
  end

  test "should update pomodoro_task" do
    patch pomodoro_task_url(@pomodoro_task), params: { pomodoro_task: { objective: @pomodoro_task.objective, user_id: @pomodoro_task.user_id } }
    assert_redirected_to pomodoro_task_url(@pomodoro_task)
  end

  test "should destroy pomodoro_task" do
    assert_difference('PomodoroTask.count', -1) do
      delete pomodoro_task_url(@pomodoro_task)
    end

    assert_redirected_to pomodoro_tasks_url
  end
end
