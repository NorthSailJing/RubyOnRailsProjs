require "application_system_test_case"

class TastsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
  end

  teardown do
	   sign_out users(:one)
  end

  def fill_in_task_form
    fill_in "task_title", with: "Ruby on Rails 6.0 Challenge"
    fill_in "task_body", with: "Build a task demo using Rails Ruby on Rails 6.0. And check how to use devise for the authentication."
    select "NorthSail"
    fill_in "task_duration", with: 20
    check "task_status"
  end

  test "user can add | edit | delete a task" do
    visit tasks_url

    click_on "New Task"
    assert_selector "h1", text: "Create New Task"
    fill_in_task_form
    click_on "Create Task"
	  assert_selector "h1", text: "Tasks List"

    click_on "Edit"
    assert_selector "h1", text: "Update the Task"
    fill_in_task_form
    click_on "Update Task"
	  assert_selector "h1", text: "Tasks List"

    accept_confirm do
      click_on "Delete"
    end
    assert_selector "h1", text: "Tasks List"
  end

end
