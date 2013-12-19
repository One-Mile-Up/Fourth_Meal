class UserSessionsController < ApplicationController
after_action :return_to_path, except: [:new, :create, :destroy]

  def new
  end

  def create
    if login(params[:username], params[:password])
      flash.notice = "Successfully logged in as #{current_user.username}"
      redirect_to session[:return_to]
    else
      flash.notice = "Login failed"
      redirect_to login_path
    end
  end

  def destroy
    logout
    flash.notice = "Logged out"
    redirect_to root_path
  end
end
