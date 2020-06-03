class UserMailer < ApplicationMailer

  # account_activationメソッドを(user.rbのuser_activation_emailで呼び出して最終的に)userコントローラーから呼び出す
  def account_activation(user)
    @user = user
    mail to: user.email # => mail object
      # =>    app/views/user_mailer/account_activation.text.erb
      # =>    app/views/user_mailer/account_activation.html.erb
      # https://hogehoge.com/account_activations/:id/edit
      # :id <= @user.activation_token
  end

  def password_reset
    @greeting = "Hi"
    mail to: "to@example.org"
  end
end
