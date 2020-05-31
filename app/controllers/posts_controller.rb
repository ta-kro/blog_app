class PostsController < ApplicationController
  before_action :logged_in_user, except: [:home, :about]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def home
  end

  def about
  end

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    # @post = Post.new(post_params)
    @user = User.find(@current_user.id)
    @post = @user.posts.build(post_params)
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      @post.touch
      flash[:notice] = "編集しました"
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:danger] = "削除しました"
    redirect_to posts_path
  end

  
  private
  def post_params
    params.require(:post).permit(:content)
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @post = Post.find(params[:id])
    if @post.user_id != @current_user.id
      flash[:danger] = "権限がありません"
      redirect_to posts_path
    end
  end

end
