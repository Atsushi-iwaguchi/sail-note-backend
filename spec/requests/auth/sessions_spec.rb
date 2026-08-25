require 'rails_helper'

RSpec.describe "Api::V1::Auth::Sessions", type: :request do
  describe "POST /api/v1/auth/login" do
    let!(:user) do
      create(:user)
    end

    it "正しいメールアドレスとパスワードでログインできる" do
      post "/api/v1/auth/login",
        params: {
          email: "test@example.com",
          password: "password123"
        },
        as: :json

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json["user"]["user_id"]).to eq(user.id)
      expect(json["user"]["username"]).to eq(user.username)
      expect(json["user"]["email"]).to eq(user.email)
      expect(json["token"]).to be_present
    end

    it "パスワードが間違っている場合は401を返す" do
      post "/api/v1/auth/login",
        params: {
          email: "test@example.com",
          password: "wrong_password"
          },
          as: :json

      expect(response).to have_http_status(:unauthorized)

      json = JSON.parse(response.body)

      expect(json["error"]).to eq("メールアドレスまたはパスワードが無効です")
    end

    it "存在しないメールアドレスの場合は401を返す" do
      post "/api/v1/auth/login",
        params: {
          email: "not-found@example.com",
          password: "password123"
          },
          as: :json

      expect(response).to have_http_status(:unauthorized)

      json = JSON.parse(response.body)

      expect(json["error"]).to eq("メールアドレスまたはパスワードが無効です")
    end
  end
end
