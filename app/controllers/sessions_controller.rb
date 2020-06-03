class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      # activatedがtrueになっていれば(user.activateされていれば)ログイン可能
      if user.activated?
        log_in user
        # チェックボックスがオンの時'1'、オフの時'0'
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        flash[:success] = "ログインしました"
        #フレンドリーフォワーディング
        redirect_back_or user
      else
        message  = "アカウントが有効化されていません "
        message += "アカウント有効化リンクを確認してください"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = '不正なメールアドレス・パスワードです'
      render 'new'
    end
  end

  # DELETE /logout
  def destroy
    log_out if logged_in?
    flash[:notice] = 'ログアウトしました'
    redirect_to root_path
  end
end
