class CommentsController < ApplicationController
    def create
        # rails routeで確認する  
        # todo: :post_idになるのはなぜか
        @post = Post.find(params[:post_id])
        # バリデーションなしで良いので、createにする。
        # newはモデルオブジェクトの生成のみ.saveを使う
        # createは生成し、saveする
        # validationつける時は生成して保存時にチェックするので、newからやる
        @post.comments.create(comment_params)
        # TODO: この@postの働きについて
        redirect_to post_path(@post)
    end

    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post)
    end

    private
        def comment_params
            #1. params
            #2.paramsの中の:postというモデルオブジェクトから来るデータを参照する
            #   requrireで引数に設定したキーの値だけ取得できる
            #3.permitは許可したいものだけを書く。
            params.require(:comment).permit(:body)
        end
end
