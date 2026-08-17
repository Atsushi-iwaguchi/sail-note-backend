require "test_helper"

class Api::V1::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should login" do
    # テストユーザーの作成
    User.create!(
      username: "testuser",
      email: "test@example.com",
      password: "password",
      password_confirmation: "password",
      boat_class: "SNIPE"
    )

    post api_v1_auth_login_url, params: {
      email: "test@example.com",
      password: "password"
    }

    assert_response :success
  end
end
