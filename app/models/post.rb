class Post < ApplicationRecord
    # commentモデルと紐付いてることを表現
    # 1.記事とコメントが1対nの関係なのでhas_many
    # 2. 記事を作事をするとcommentsも削除する
    has_many :comments,dependent: :destroy
    # @post.commentsで引っ張ってこれる
    # messageがある場合、presenceはtureと書かなくてもerror検出する
    validates :author,  length: {maximum: 10, message: '10文字以内で入力してください'}
    validates :title, presence: {message: 'タイトルを入力してください'} , length: {minimum: 3,message: '3文字以上入力してください'}
    validates :body, presence: {message: '内容を入力してください'}
    validates :password, presence: {message: 'パスワードを入力してください'} #, length: {minimum: 4, maximum: 10, message: '4文字以上、10文字以内で入力してください'}
end
