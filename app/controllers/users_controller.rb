class UsersController < ApplicationController
  def index
    @users = User.all
    @user = User.new
  end
  
  def show
     @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end
  
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
  
  def is_matching_login_user
     user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
  
end
