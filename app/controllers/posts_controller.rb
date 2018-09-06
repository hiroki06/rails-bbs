class PostsController < ApplicationController
    # actionのこと(rails routesででてくるgetしたときの関数)
    def index
        @posts = Post.all.order(created_at: 'desc')
        @post = Post.new
    end

    def show
        @post = Post.find(params[:id])
    end

    def new
        # new.html.erbで@postを使っているのに、controllerにないと、できなくなる。
        # 要するに、一番最初に開いたときは、@postが無いので、erorが出る
        @post = Post.new

    end

    def edit # 編集画面というような感じ
        # 編集時には個々のデータがほしいので、showと同じように書ける
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        # validateを掛ける
        if @post.update(post_params)
            redirect_to posts_path
        else
            render 'edit'
        end
    end

    def destroy
        @post = Post.find(params[:id])
        # if @post.id == params[:password]
        @post.destroy
        # 削除された画面を反映させる
        redirect_to posts_path
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
        if @post.save
        # redirect ここでは記事一覧にリダイレクトするprefixが使える
            redirect_to posts_path
        else
            # test用
            # render plain: @post.errors.inspect

            # newと同じviewに表示する
            @posts = Post.all.order(created_at: 'desc')
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
end
