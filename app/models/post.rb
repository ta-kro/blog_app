class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: {maximum: 140, message: "は140字以内で入力してください"}
end
