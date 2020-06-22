require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is invalid without a content' do
    post = Post.new(content: nil)
    post.valid?
    expect(post.errors[:content]).to include("を入力してください")
  end

  it 'is invalid with a content more than 200 letters' do
    post = Post.new(content: "#{"osashimi"*26}")
    post.valid?
    expect(post.errors[:content]).to include("は200文字以内で入力してください")
  end
end
