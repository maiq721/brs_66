class ApplicationController < ActionController::Base
  include SessionsHelper

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_path unless current_user? @user
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:warning] = t ".not_exit"
    redirect_to root_path
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = t ".not_login"
    redirect_to login_url
  end

  def verify_admin
    return if current_user&.role == Settings.admin.role
    redirect_to login_path
    flash[:warning] = t ".should_login" 
  end
end
