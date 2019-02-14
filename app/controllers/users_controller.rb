class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  
  def show
    @user = User.find(params[:id])
    @user_loves = @user.love_animes
    @count_loves = @user.love_animes.count
    @count_hates = @user.hate_animes.count
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "ユーザを登録しました。"
      redirect_to @user
    else
      flash.now[:danger] = "ユーザの登録に失敗しました。"
      render :new
    end
  end
  
  def hates
    @user = User.find(params[:id])
    @user_hates = @user.hate_animes
    @count_loves = @user.love_animes.count
    @count_hates = @user.hate_animes.count
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
