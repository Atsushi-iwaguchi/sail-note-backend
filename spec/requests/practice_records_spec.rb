require "rails_helper"

RSpec.describe "Api::V1::PracticeRecords", type: :request do
  it "JWTが不正の場合401を返す" do
    get "/api/v1/practice_records",
      headers: {
        "Authorization" => "Bearer invalid_token"
      }

      expect(response).to have_http_status(:unauthorized)
  end

  describe "GET /api/v1/practice_records" do
    let!(:user) { create(:user) }

    let(:token) do
      JWT.encode(
        user.to_token_payload,
        Rails.application.secret_key_base,
        "HS256"
      )
    end

    let(:headers) do
      {
        "Authorization" => "Bearer #{token}"
      }
    end

    it "認証していない場合401を返す" do
      get "/api/v1/practice_records"

      expect(response).to have_http_status(:unauthorized)
    end

    it "認証済みの場合練習記録を取得できる" do
       practice_record = create(:practice_record, user: user)

      get "/api/v1/practice_records",
        headers: headers

      expect(response).to have_http_status(:ok)

       json = JSON.parse(response.body)

       expect(json.length).to eq(1)
       expect(json[0]["id"]).to eq(practice_record.id)
       expect(json[0]["practice_date"]).to eq(practice_record.practice_date.to_s)
    end

    it "from_dateで絞り込み検索をする" do
      target_record = create(
        :practice_record,
        user: user,
        practice_date: Date.new(2026, 8, 20)
      )

      create(
        :practice_record,
        user: user,
        practice_date: Date.new(2026, 8, 10)
      )

      get "/api/v1/practice_records",
        params: {
            from_date: "2026-08-15"
        },
        headers: headers

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json.length).to eq(1)
      expect(json[0]["id"]).to eq(target_record.id)
    end

    it "to_dateで絞り込み検索をする" do
      target_record = create(
        :practice_record,
        user: user,
        practice_date: Date.new(2026, 8, 10)
      )

      create(
        :practice_record,
        user: user,
        practice_date: Date.new(2026, 8, 20)
      )

      get "/api/v1/practice_records",
        params: {
            to_date: "2026-08-15"
        },
        headers: headers

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json.length).to eq(1)
      expect(json[0]["id"]).to eq(target_record.id)
    end

    it "指定した練習記録を取得" do
      practice_record = create(:practice_record, user: user)

      get "/api/v1/practice_records/#{practice_record.id}",
        headers: headers

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json["id"]).to eq(practice_record.id)
    end
  end

  describe "POST /api/v1/practice_records" do
    let!(:user) { create(:user) }

    let(:token) do
      JWT.encode(
        user.to_token_payload,
        Rails.application.secret_key_base,
        "HS256"
      )
    end

    let(:headers) do
      {
        "Authorization" => "Bearer #{token}"
      }
    end

    it "認証済みユーザーが練習記録を作成できる" do
      expect {
        post "/api/v1/practice_records",
          params: {
            practice_record: {
              practice_date: Date.current,
              wind_direction: "北",
              min_wind_speed: 5,
              max_wind_speed: 10,
              tide: "oshio",
              content: "今日は風が強かった"
            }
          },
          headers: headers
      }.to change(PracticeRecord, :count).by(1)

      expect(response).to have_http_status(:created)

      json = JSON.parse(response.body)

      expect(json["practice_date"]).to eq(Date.current.to_s)
      expect(json["wind_direction"]).to eq("北")
      expect(json["min_wind_speed"]).to eq(5)
      expect(json["max_wind_speed"]).to eq(10)

      # ユーザーとの紐付きを確認
      record = PracticeRecord.last
      expect(record.user).to eq(user)
    end

      it "practice_dateがない場合422を返す" do
        expect {
        post "/api/v1/practice_records",
            params: {
            practice_record: {
                wind_direction: "北",
                min_wind_speed: 5,
                max_wind_speed: 10,
                tide: "oshio",
                content: "今日は風が強かった"
            }
            },
            headers: headers
        }.not_to change(PracticeRecord, :count)

        expect(response).to have_http_status(:unprocessable_content)
    end
  end

  describe "PATCH /api/v1/practice_records/:id" do
    let!(:user) { create(:user) }

    let(:token) do
      JWT.encode(
        user.to_token_payload,
        Rails.application.secret_key_base,
        "HS256"
      )
    end

    let(:headers) do
      {
        "Authorization" => "Bearer #{token}"
      }
    end

    it "自身の練習記録を編集できる" do
      practice_record = create(:practice_record, user: user)

      patch "/api/v1/practice_records/#{practice_record.id}",
        params: {
                practice_record: {
                min_wind_speed: 2
                }
            },
        headers: headers

      json = JSON.parse(response.body)
      expect(json["min_wind_speed"]).to eq(2)
      expect(practice_record.reload.min_wind_speed).to eq(2)
    end

    it "他ユーザーの練習記録は編集できない" do
      dummy_user = create(:user, email: "dummy@example.com")

      practice_record = create(:practice_record, user: dummy_user)

      patch "/api/v1/practice_records/#{practice_record.id}",
        params: {
                practice_record: {
                min_wind_speed: 2
                }
            },
        headers: headers

      expect(response).to have_http_status(:not_found)
      expect(practice_record.reload.min_wind_speed).not_to eq(2)
    end
  end

  describe "DELETE /api/v1/practice_records/:id" do
    let!(:user) { create(:user) }

    let(:token) do
      JWT.encode(
        user.to_token_payload,
        Rails.application.secret_key_base,
        "HS256"
      )
    end

    let(:headers) do
      {
        "Authorization" => "Bearer #{token}"
      }
    end

    it "自身の練習記録を削除できる" do
      practice_record = create(:practice_record, user: user)

      expect {
        delete "/api/v1/practice_records/#{practice_record.id}",
        headers: headers
      }.to change(PracticeRecord, :count).by(-1)

      expect(response).to have_http_status(:ok)
      expect(PracticeRecord.exists?(practice_record.id)).to be false
    end

    it "他ユーザーでは削除できない" do
      dummy_user = create(:user, email: "dummy@example.com")
      practice_record = create(:practice_record, user: dummy_user)

        delete "/api/v1/practice_records/#{practice_record.id}",
          headers: headers

      expect(response).to have_http_status(:not_found)
      expect(PracticeRecord.exists?(practice_record.id)).to be true
    end
  end
end
