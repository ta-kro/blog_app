class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 200, message: "は200文字以内で入力してください"}
  validate :picture_size

  private

  def picture_size
    if picture.size > 1.megabytes
      errors.add(:picture, "1MB以内")
    end
  end
end
