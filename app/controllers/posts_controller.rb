require "digest/sha2"

class PostsController < ApplicationController
    # actionのこと(rails routesででてくるgetしたときの関数)
    protect_from_forgery except: :destroy
    def index
        # @posts = Post.all.order(updated_at: 'desc')
        @posts = Post.page(params[:page]).order('updated_at DESC')
        @post = Post.new
    end

    def show
        @post = Post.find(params[:id])
    end

    def edit
        # 編集時には個々のデータがほしいので、showと同じように書ける
            @post = Post.find(params[:id])

    end

    def update
        @post = Post.find(params[:id])
        input_pass = to_sha2(params[:post][:password])
        correct_pass = @post[:password]
        binding.pry
        # errorを表示するためpasswordをnilにする
        if params[:commit] && input_pass == correct_pass
             params[:post][:password] = input_pass
        else
             params[:post][:password] = nil
        end
        if @post.update(post_params)
            redirect_to root_path
        else
            render :edit
        end
    end

    def destroy
        @post = Post.find(params[:id])
        if @post[:password] == to_sha2(params[:post][:password])
            @post.destroy
            redirect_to root_path
        else
            # エラー表示するため、passwordを一度空にする
            params[:post][:password] = nil
            @post.update(params.require(:post).permit(:password))
            render :edit
        end
    end

    def create
        # test用
        # render plain: params[:post].inspect
=begin
        ':post'は new.html.erbの form_forの:postに対応する
        railsでは 不正な値を防ぐ機能がある
        よって、
            @post = Post.new(params[:post])
            @post.save
        ではエラーが出るようになる
        そこでstrong parameterを使う(下記参照)
=end
        # storong parameterを使用する
        @post = Post.new(post_params)
        # validationに失敗した時はfalseが返ってくる
        if @post.author.empty?
            @post.author = "名無しさん"
        end
        # hash化
        if !@post.password.empty?
            @post.password = to_sha2(@post.password)
        end
        if @post.save
        # redirect ここでは記事一覧にリダイレクトするprefixが使える
            redirect_to root_path
        else
            # test用
            # render plain: @post.errors.inspect

            # newと同じviewに表示する
            @posts = Post.page(params[:page]).order(updated_at: 'desc')
            render 'index'
        end
    end

    private
    # mass assignment 脆弱性の対策
        def post_params
            #1. params
            #2.paramsの中の:postというモデルオブジェクトから来るデータを参照する
            #   requrireで引数に設定したキーの値だけ取得できる
            #3.permitは許可したいものだけを書く。
            params.require(:post).permit(:author,:title,:body,:password)
        end

# 便利な関数
    def to_sha2(str)
        Digest::SHA256.hexdigest(str)
    end
end
