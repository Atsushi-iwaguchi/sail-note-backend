class Api::V1::Auth::SessionsController < ApplicationController
  #ログイン用, 登録済みユーザーを確認してJWTを発行する
  def create
    user = User.find_by(email: params[:email])

    #user.authenticate("パスワード")→パスワードが正しければuserオブジェクト, 違えばfalseを返す
    if user && user.authenticate(params[:password])
      token = generate_token(user)
      render json: {
        user: { id: user.id, email: user.email },
        token: token
      }
    else
      render json: { error: "メールアドレスまたはパスワードが無効です" }, status: :unauthorized
    end
  end

  private
  def generate_token(user)
    payload = user.to_token_payload
    JWT.encode(payload, Rails.application.secret_key_base, 'HS256')
  end
end
