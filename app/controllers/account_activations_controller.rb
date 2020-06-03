class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    # !user.activated?は一度有効化されたアカウントの再有効化禁止(activatedはカラムの名前)
    # user.authenticated?でauthenticate_digestの値と比較
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate #user.rbに定義
      log_in user
      flash[:success] = "アカウント認証が完了しました"
      redirect_to user
    else
      # tokenの値が一致しなかった=作成しようとしたアカウントとは違うメアドでリンクをクリックした時、falseになる
      flash[:danger] = "アカウント認証はできません"
      redirect_to root_url
    end
  end
end
