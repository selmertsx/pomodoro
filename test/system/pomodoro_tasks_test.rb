require "application_system_test_case"

class PomodoroTasksTest < ApplicationSystemTestCase
  setup do
    @pomodoro_task = pomodoro_tasks(:one)
  end

  test "visiting the index" do
    visit pomodoro_tasks_url
    assert_selector "h1", text: "Pomodoro Tasks"
  end

  test "creating a Pomodoro task" do
    visit pomodoro_tasks_url
    click_on "New Pomodoro Task"

    fill_in "Objective", with: @pomodoro_task.objective
    fill_in "User", with: @pomodoro_task.user_id
    click_on "Create Pomodoro task"

    assert_text "Pomodoro task was successfully created"
    click_on "Back"
  end

  test "updating a Pomodoro task" do
    visit pomodoro_tasks_url
    click_on "Edit", match: :first

    fill_in "Objective", with: @pomodoro_task.objective
    fill_in "User", with: @pomodoro_task.user_id
    click_on "Update Pomodoro task"

    assert_text "Pomodoro task was successfully updated"
    click_on "Back"
  end

  test "destroying a Pomodoro task" do
    visit pomodoro_tasks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pomodoro task was successfully destroyed"
  end
end
