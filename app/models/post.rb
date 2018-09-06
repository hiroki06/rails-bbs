class Post < ApplicationRecord
    # commentモデルと紐付いてることを表現
    # 1.記事とコメントが1対nの関係なのでhas_many
    # 2. 記事を作事をするとcommentsも削除する
    has_many :comments,dependent: :destroy
    # @post.commentsで引っ張ってこれる
    # messageがある場合、presenceはtureと書かなくてもerror検出する
    validates :title, presence: {message: 'タイトルを入力してください'} , length: {minimum: 3,message: '3文字以上入力してください'}
    validates :body, presence: {message: '内容を入力してください'}
end
