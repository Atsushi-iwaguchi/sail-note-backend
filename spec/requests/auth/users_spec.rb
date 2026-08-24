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

      expect(response).to have_http_status(:created)
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
    end

    it "emailがない場合は422を返す" do
      params = valid_params.deep_dup
      params[:user].delete(:email)

      post "/api/v1/auth/register",
        params: params,
        as: :json

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end