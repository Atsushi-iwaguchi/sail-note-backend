class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

    has_many :practice_records, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :tournament_entries, dependent: :destroy
    has_many :race_results, through: :tournament_entries

    enum :role, { member: 0, leader: 1 }

    # JWTトークン用にユーザー情報をペイロードに変換
    def to_token_payload
        {
            sub: id,
            email: email,
            role: role,
            exp: 24.hours.from_now.to_i # 有効期限
        }
    end
end
