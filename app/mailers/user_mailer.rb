class UserMailer < ApplicationMailer

  # account_activationメソッドを(user.rbのuser_activation_emailで呼び出して最終的に)userコントローラーから呼び出す
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "アカウント認証"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "パスワード再設定"
  end
end
