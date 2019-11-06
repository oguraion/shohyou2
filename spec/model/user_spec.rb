require 'rails_helper'

RSpec.describe User do
  
  before do
    @user = FactoryBot.build(:user)
  end

  context "when user is valid" do
    it "値が入っている場合" do
      expect(@user).to be_valid
    end

    it "nicknameが空白の場合" do
      @user.nickname = ""
      expect(@user).not_to be_valid
    end
    it "emailが空白の場合" do
      @user.email = ""
      expect(@user).not_to be_valid
    end
  end

  context "when email is invalid" do
    it "emailのvalidateが正しく機能しているか" do
      expect(FactoryBot.build(:user, email: "user@gmail")).not_to be_valid

      expect(FactoryBot.build(:user, email: "user@gmail,com")).not_to be_valid

      expect(FactoryBot.build(:user, email: "user_at_gmail.com")).not_to be_valid
    end
  end

  context "when email adresses should be unique" do
    it "emailの一意性制約が正しく機能しているか" do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save!
      expect(duplicate_user).to be_invalid
    end

    it "emailを小文字に変換後の値と大文字を混ぜて登録されたアドレスが同じか" do
      @user.email = "Foo@GmaIL.CoM"
      @user.save!
      expect(@user.reload.email).to eq "foo@gmail.com"
    end
  end

  it "passwordが空白になっていないか" do
    @user.password = @user.password_confirmation = ""
    expect(@user).not_to be_valid
  end
end
