class PostsController < ApplicationController
  before_action :logged_in_user, except: [:index]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.paginate(page: params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      @post.touch
      flash[:notice] = "編集しました"
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:danger] = "削除しました"
    redirect_to posts_path
  end

  
  private
  def post_params
    params.require(:post).permit(:content, :picture)
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:danger] = "権限がありません"
      redirect_to root_path
    end
  end

end
