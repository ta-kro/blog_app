class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :forbid_login_user, only: [:new, :create, :login_form, :login]
  before_action :admin_user, only: :destroy

  def index
    # ページ表示件数(デフォルトは30件)を「:per_pagr: 数」で指定可能
    @users = User.paginate(page: params[:page], per_page: 10)
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
      @user.send_activation_email #user.rbに定義
      flash[:info] = "確認メールを開いて登録を完了させてください"
      # ここでログインはしない
      # log_in @user
      # flash[:success] = "登録が完了しました"
      redirect_to user_path(@user)
      # GET "/users/#{@user.id}" => show
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
      flash[:success] = "アカウントを編集しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "アカウントを削除しました"
    #indexに表示させるから多分あってる
    redirect_back(fallback_location: users_path)
  end



  private

  def user_params
    params.require(:user).permit(:name, :email, :image_name, :password, :password_confirmation)
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      flash[:danger] = "権限がありません"
      redirect_to(root_path)
    end
  end

  def forbid_login_user
    if logged_in?
      flash[:danger] = "すでにログインしています"
      redirect_to root_path
    end
  end

  #adminカラムを付与後
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end


