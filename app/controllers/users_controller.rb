class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".success"
      redirect_to root_path
    else
      flash[:danger] = t ".danger"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :username, :email, :password,
      :password_confirmation
  end
end
