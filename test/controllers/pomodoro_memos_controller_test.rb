require 'test_helper'

class PomodoroMemosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pomodoro_memo = pomodoro_memos(:one)
  end

  test "should get index" do
    get pomodoro_memos_url
    assert_response :success
  end

  test "should get new" do
    get new_pomodoro_memo_url
    assert_response :success
  end

  test "should create pomodoro_memo" do
    assert_difference('PomodoroMemo.count') do
      post pomodoro_memos_url, params: { pomodoro_memo: { memo: @pomodoro_memo.memo, pomodoro_task_id: @pomodoro_memo.pomodoro_task_id } }
    end

    assert_redirected_to pomodoro_memo_url(PomodoroMemo.last)
  end

  test "should show pomodoro_memo" do
    get pomodoro_memo_url(@pomodoro_memo)
    assert_response :success
  end

  test "should get edit" do
    get edit_pomodoro_memo_url(@pomodoro_memo)
    assert_response :success
  end

  test "should update pomodoro_memo" do
    patch pomodoro_memo_url(@pomodoro_memo), params: { pomodoro_memo: { memo: @pomodoro_memo.memo, pomodoro_task_id: @pomodoro_memo.pomodoro_task_id } }
    assert_redirected_to pomodoro_memo_url(@pomodoro_memo)
  end

  test "should destroy pomodoro_memo" do
    assert_difference('PomodoroMemo.count', -1) do
      delete pomodoro_memo_url(@pomodoro_memo)
    end

    assert_redirected_to pomodoro_memos_url
  end
end
