class UsersController < ApplicationController
  # before_action :authenticate_user, only: [:index, :show, :edit, :update]
  # before_action :forbid_login_user, only: [:new, :create, :login_form, :login]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @user = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id]  = @user.id
      flash[:notice] = "登録が完了しました"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      #画像を保存する必要あり
      # @user.image_name = "#{@user.id}.jpg"
      # File.binwrite @user.image_name, params[:image_name].read
      flash[:notice] = "アカウントを編集しました"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  # 削除ボタンは未実装
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "アカウントを削除しました"
    redirect_to users_path
  end

  def login_form
  end

  def login
  end

  def logout
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirm)
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

end
