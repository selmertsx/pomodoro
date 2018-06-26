require "application_system_test_case"

class PomodoroMemosTest < ApplicationSystemTestCase
  setup do
    @pomodoro_memo = pomodoro_memos(:one)
  end

  test "visiting the index" do
    visit pomodoro_memos_url
    assert_selector "h1", text: "Pomodoro Memos"
  end

  test "creating a Pomodoro memo" do
    visit pomodoro_memos_url
    click_on "New Pomodoro Memo"

    fill_in "Memo", with: @pomodoro_memo.memo
    fill_in "Pomodoro Task", with: @pomodoro_memo.pomodoro_task_id
    click_on "Create Pomodoro memo"

    assert_text "Pomodoro memo was successfully created"
    click_on "Back"
  end

  test "updating a Pomodoro memo" do
    visit pomodoro_memos_url
    click_on "Edit", match: :first

    fill_in "Memo", with: @pomodoro_memo.memo
    fill_in "Pomodoro Task", with: @pomodoro_memo.pomodoro_task_id
    click_on "Update Pomodoro memo"

    assert_text "Pomodoro memo was successfully updated"
    click_on "Back"
  end

  test "destroying a Pomodoro memo" do
    visit pomodoro_memos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pomodoro memo was successfully destroyed"
  end
end
