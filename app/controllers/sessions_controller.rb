class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      log_in user
      if params[:session][:remember_me] == Settings.session.remember
        forget user
      else
        remember user
      end
      redirect_to root_path
    else
      flash.now[:danger] = t ".danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
