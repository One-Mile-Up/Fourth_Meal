class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_action :return_to_path

  def require_admin
    if current_user
      unless current_user.admin
        redirect_to user_path(current_user)
      end
    end
  end

  def current_restaurant
    if params[:restaurant_slug]
    Restaurant.find_by(slug: params[:restaurant_slug])
    elsif params[:id]
      Restaurant.find(params[:id])
    end
  end

  def require_owner
    if current_user
      unless current_restaurant.users.include?(current_user) || current_user.admin
	redirect_to user_path(current_user)
      end
    end
  end

  def return_to_path
    session[:return_to] = request.fullpath
  end

end
