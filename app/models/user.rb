class User < ApplicationRecord
  attr_accessor :remember_token
  has_secure_password
  mount_uploader :image_name, ImageNameUploader
  has_many :posts, dependent: :destroy

  before_save :downcase_email
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: {minimum: 6},  allow_nil: true

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザーをデータベースに記憶する(remember_digestカラムにremember_token(ランダムなトークン)のハッシュ値を保存)
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # ユーザーのログイン情報を破棄
  def forget
    update_attribute(:remember_digest, nil)
  end

  # 渡されたトークンがダイジェストにある(ハッシュ化された)remember_tokenと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end


  private
  def downcase_email
    self.email = email.downcase
  end

end
