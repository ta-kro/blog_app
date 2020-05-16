class Post < ApplicationRecord
  validates :content, presence: true, length: {maximum: 140, message: "は140字以内で入力してください"}
end
