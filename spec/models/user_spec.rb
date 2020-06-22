require 'rails_helper'

RSpec.describe User, type: :model do
  
  it "has a valid factory" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it "is invalid with a name more than 50 letters" do
    user = build(:user, name: "#{'abe'*17}")
    user.valid?
    expect(user.errors[:name]).to include("は50文字以内で入力してください")
  end

  it "is invalid without an email adress" do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "is invalid with an email adress more than 255 letters" do
    user = build(:user, email: "#{'a'*255}@example.com")
    user.valid?
    expect(user.errors[:email]).to include("は255文字以内で入力してください")
  end

  it "is invalid with an incorrect email adress format" do
    user = build(:user, email: "#sampleexample.com")
    user.valid?
    expect(user.errors[:email]).to include("は不正な値です")
  end
  
  it "is invalid with a duplicate email address" do
    create(:user, email: "sample@example.com")
    user = build(:user, email: "sample@example.com")
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

  it "is invalid with a password less than 6 letters" do
    user = build(:user, password: "test")
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上で入力してください")
  end

  it "is invalid with an incorrect password confirmation" do
    user = build(:user, password_confirmation: "")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
  end
end
