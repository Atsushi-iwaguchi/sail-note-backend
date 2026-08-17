require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should create user" do
    post api_v1_auth_register_url, params: {
      user: {
        username: "testuser",
        email: "test@example.com",
        password: "password",
        password_confirmation: "password",
        boat_class: "Snipe"
      }
    }

    assert_response :created
  end
end
