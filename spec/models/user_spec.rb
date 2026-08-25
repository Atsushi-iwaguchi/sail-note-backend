require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーション" do
    it "emailがない場合は無効になる" do
      user = build(:user, email: nil)

      expect(user).not_to be_valid
    end
    it "emailが重複すると無効になる" do
      create(:user, email: "test@example.com")

      user = build(:user, email: "test@example.com")

      expect(user).not_to be_valid
    end

    it "emailのフォーマットになっていないと無効になる" do
      user = build(:user, email: "asdf1231321")

      expect(user).not_to be_valid
    end

    it "パスワードが5文字以内なら無効になる" do
      user = build(:user, password: "asdf1")

      expect(user).not_to be_valid
    end
  end
end
