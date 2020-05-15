class PostsController < ApplicationController
  def home
  end

  def about
  end

  def index
    @post = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
