class UsersController < ApplicationController
  def index
    @user = User.all.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params_create)
    if @user.save
      session[:user_id]  = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to users_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def login_form
  end

  def login
  end

  def logout
  end

  private
  def user_params_create
    params.require(:user).permit(:name, :email, :password, :password_confirm)
  end

  def user_params_edit
    params.require(:user).permit(:name, :email)
  end
end
