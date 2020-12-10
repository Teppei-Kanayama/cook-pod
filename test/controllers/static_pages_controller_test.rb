require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get recommend" do
    get static_pages_recommend_url
    assert_response :success
  end

  test "should get calendar" do
    get static_pages_calendar_url
    assert_response :success
  end

end
