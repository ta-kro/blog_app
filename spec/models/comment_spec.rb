require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'is invalid without body' do
    comment = Comment.new(body: nil)
    comment.valid?
    expect(comment.errors[:body]).to include("を入力してください")
  end

end
