require "test_helper"

class Api::V1::SettionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_settions_create_url
    assert_response :success
  end
end
