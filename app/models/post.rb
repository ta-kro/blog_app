class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :content, presence: true, length: {maximum: 140, message: "は140字以内で入力してください"}
end
