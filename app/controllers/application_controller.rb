class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :is_login?

  private

  def is_login?
    # sessionidがある場合、現在のuser情報を取得する
    if session[:user_id]
        @current_user = User.find_by(id: session[:user_id])
    else
    # loginページに飛ばす。※sission create、user create, loginページでは飛ばないようにする。
        redirect_to login_path
    end
  end
end