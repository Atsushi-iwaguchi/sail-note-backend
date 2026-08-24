require "rails_helper"

RSpec.describe "Api::V1::PracticeRecords", type: :request do
  describe "GET /api/v1/practice_records" do
    let!(:user) { create(:user) }

    let(:token) do  
      JWT.encode(
        user.to_token_payload,
        Rails.application.secret_key_base,
        "HS256"
      )
    end

    it "認証していない場合401を返す" do
      get "/api/v1/practice_records"

      expect(response).to have_http_status(:unauthorized)
    end

    it "認証済みの場合200を返す" do
      get "/api/v1/practice_records",
        headers: {
          "Authorization" => "Bearer #{token}"
        }

      expect(response).to have_http_status(:ok)
    end
  end

  it "JWTが不正の場合401を返す" do
    get "/api/v1/practice_records",
      headers: {
        "Authorization" => "Bearer invalid_token"
      }

      expect(response).to have_http_status(:unauthorized)
  end
end