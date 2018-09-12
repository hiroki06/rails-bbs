Rails.application.routes.draw do
  get 'mypage', to: 'users#me'
  get 'login', to: 'users#login'
  post 'login', to: 'users#login'
  post 's_create', to: 'sessions#create'
  delete 's_delete', to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    # postsモデルだけ使う場合
    # resources :posts
    # postsモデルにcommentsモデルを紐づける場合
    resources :users, only: %i[new create]
    resources :posts do
        # only:で使う
        resources :comments, only: [:create,:destroy]
    end

    root 'posts#index'
end
