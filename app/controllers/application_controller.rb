class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
    #ログイン済みのユーザーかどうかを確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "このページにアクセスするにはログインしてください"
        redirect_to login_url
      end
    end
end
