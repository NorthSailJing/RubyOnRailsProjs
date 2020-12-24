require "application_system_test_case"

class TastsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:one)
  end

  test "can sign in 1" do
    visit tasks_url
    assert_selector "h1", text: "Tasks List"
  end

  test "can sign in 2" do
    visit tasks_url
    assert_selector "h1", text: "Tasks List"
  end

end
