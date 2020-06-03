# Preview all emails at 192.168.33.10:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def account_activation
    user = User.first
    user.activation_token = User.new_token
    UserMailer.account_activation(user) # => mail object
  end

  def password_reset
    UserMailer.password_reset
  end

end
