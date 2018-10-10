require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
   @post = FactoryBot.build(:post)
  end
  describe "basic" do
    it "is valid" do
      expect(@post).to be_valid
    end
  end
  describe "auther attr" do
    context "length validation" do
      it "author is valid less 10 length" do
        @post.author = "123456789"
        expect(@post).to be_valid
      end
      it "author is valid 10 length exactly" do
        @post.author = "1234567890"
        expect(@post).to be_valid
      end
      it "author is invalid  more than 10 length" do
        @post.author = "12345678901"
        @post.valid?
        expect(@post.errors[:author]).to include("10文字以内で入力してください")
      end
      it "author is valid when it is none" do
        @post.author = ""
        # postdd.@valid?
        # expect(post.outhor).to eq "名無しさん"
        expect(@post).to be_valid
      end
      
    end
  end
  describe "title attr" do
    context "presence validation" do
      it "is invalid presence" do
        @post.title = ""
        @post.valid?
        expect(@post.errors[:title]).to include("タイトルを入力してください")
      end
    end
    context "length" do
      it "is invalid when less than 3 letters" do
        @post.title = "12"
        @post.valid?
        expect(@post.errors[:title]).to include("3文字以上入力してください")
      end
      it "is valid when 3 letter exactly" do
        @post.title = "123"
        expect(@post).to be_valid
      end
    end
  end
  describe "body attr" do
    it 'is invalid when presence is empty' do
      @post.body = ""
      @post.valid?
      expect(@post.errors[:body]).to include("内容を入力してください")
    end
  end
  describe "password attr" do
    it 'is invalid when presence is empty' do
      @post.password = ""
      @post.valid?
      expect(@post.errors[:password]).to include("パスワードが異なるか、入力されていません")
    end
    it 'is invalid when is nil' do
      @post.password = nil
      @post.valid?
      expect(@post.errors[:password]).to include("パスワードが異なるか、入力されていません")
    end
    it 'is invalid when is defference' do
      @post.password = "defferent_password"
      @post.valid?
      expect(@post.errors[:password]).to include("パスワードが異なるか、入力されていません")
    end
  end
end
