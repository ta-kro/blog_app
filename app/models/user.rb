class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy
  before_save { email.downcase! }

  validates :name, presence: true, length: {maximum: 50}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: {minimum: 6}, on: :create
  #「on: :create」でcreateアクションの時だけバリデーションが実行される

end