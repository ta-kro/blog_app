class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @post.comments.create(comment_params)
    redirect_to @post
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    user = @post.user
    if current_user?(user)
      @comment.destroy
      redirect_to @post
    else
      flash[:danger] = "コメントは削除できません"
      render 'posts/show'
    end
  end

  private
  def  comment_params
    params.require(:comment).permit(:body)
  end

end
