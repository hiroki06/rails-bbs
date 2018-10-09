require 'rails_helper'

RSpec.describe User, type: :model do
  describe "name attribute" do

    it "is valid user" do
      user = User.new(
      name: "tester",
        password: "password"
      )
      expect(user).to be_valid
    end
  # name
    # presence
    it "is valid if no name" do
      user = User.new(
        name: "",
        password: "password",
      )
      expect(user).to_not be_valid
    end
    it "is invalid without name" do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end
    # uniqness
    it "is unique  name" do
      user_1 = User.create(name: "a",password: "password")
      user_2 = User.new(name: "a",password: "password2")
      user_2.valid?
      expect(user_2.errors[:name]).to include("has already been taken")	
    end
    # length
    it "name is valid 15 length" do
      user = User.new(name: "123456789012345",password: "password")
      expect(user).to be_valid
    end
    it "is valid maximum 16 length" do
    user = User.new(name: "1234567890123456",password: "password")
      expect(user).to be_valid
    end
    it "is invalid more than 17 length" do
      user = User.new(name: "12345678901234567",password: "password")
      user.valid?
      expect(user.errors[:name]).to include("is too long (maximum is 16 characters)")
    end
    # format
    it "can be use only half size alphabets, capitals or number" do
      user = User.new(name: "a1",password: "password")
      expect(user).to be_valid
    end
    it "name can't contain capitals" do
      user = User.new(name: "Aa1",password: "password")
      user.valid?
      expect(user.errors[:name]).to include("は小文字英数字で入力してください")
    end
  end
  describe "password attribute" do
    it "is invalid   less than 8 letter" do
      user = User.new(name: "tester", password: "1234567")
      user.valid?
      expect(user.errors[:password]).to include('is too short (minimum is 8 characters)')
    end
    it "is valid  8 letter" do
      user = User.new(name: "tester", password: "12345678")
      expect(user).to be_valid
    end
    it "is valid over 8 letter" do
      user = User.new(name: "tester", password: "123456789")
      expect(user).to be_valid
    end
  end
end
