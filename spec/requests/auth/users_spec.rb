require 'rails_helper'

RSpec.describe "Api::V1::Auth::Users", type: :request do
  describe "POST /api/v1/auth/register" do
    let(:valid_params) do
      {
        user: {
          email: "new@example.com",
          password: "password123",
          password_confirmation: "password123",
          username: "テストユーザー",
          boat_class: "470"
        }
      }
    end

    it "ユーザーを登録できる" do
      expect {
        post "/api/v1/auth/register",
          params: valid_params,
          as: :json
      }.to change(User, :count).by(1)

      # APIから返ってきたJSON文字列をRubyのHashに変換
      expect(response).to have_http_status(:created)

      json = JSON.parse(response.body)

      expect(json["user"]["username"]).to eq("テストユーザー")
      expect(json["user"]["email"]).to eq("new@example.com")
      expect(json["token"]).to be_present
      # パスワードがレスポンスに含まれていない
      expect(json["user"]).not_to have_key("password")
      expect(json["user"]).not_to have_key("password_digest")
    end

    it "emailがない場合は422を返す" do
      params = valid_params.deep_dup
      params[:user].delete(:email)

      post "/api/v1/auth/register",
        params: params,
        as: :json

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "emailが重複している場合は422を返す" do
      create(:user, email: "new@example.com")

      post "/api/v1/auth/register",
        params: valid_params,
        as: :json

      expect(response).to have_http_status(:unprocessable_entity)

      json = JSON.parse(response.body)

      expect(json["errors"]).to be_present
    end

    it "passwordとpassword_confirmationが一致しない場合は422を返す" do
      params = valid_params.deep_dup
      params[:user][:password_confirmation] = "different"

      post "/api/v1/auth/register",
        params: params,
        as: :json

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
