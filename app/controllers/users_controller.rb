class UsersController < ApplicationController
  skip_before_action :is_login?, only:[:new, :create, :login]
  def new
    @user = User.new(flash[:user])
  end

  # user新規作成時
  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to mypage_path
    else
      redirect_to '/users/new', flash: {
        user: user,
        error_messages: user.errors.full_messages
      }
    end
  end

  def me
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end