Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    # postsモデルだけ使う場合
    # resources :posts
    # postsモデルにcommentsモデルを紐づける場合
    resources :posts do
        # only:で使う
        resources :comments, only: [:create,:destroy]
    end

    root 'posts#index'
end
