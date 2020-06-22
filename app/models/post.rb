class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :content, presence: true, length: {maximum: 200, message: "は200文字以内で入力してください"}
end
