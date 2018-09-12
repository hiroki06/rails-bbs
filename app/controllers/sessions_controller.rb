class SessionsController < ApplicationController
  # loginボタンを押したときのみ
  skip_before_action :is_login?
  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to mypage_path
    else
      # render 'users/login'
      # redirect_to 'users/login'
      redirect_to login_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end
end