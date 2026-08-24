FactoryBot.define do
  factory :user do
    email { "test@example.com" }
    password { "password123" }
    username { "テストユーザー" }
    boat_class { "470" }
  end
end