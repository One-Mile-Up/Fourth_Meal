class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_admin
    if current_user
      unless current_user.admin
        redirect_to user_path(current_user)
      end
    end
  end

  def current_restaurant
    Restaurant.find_by(slug: params[:restaurant_slug])
  end

  def require_owner
    if current_user
      unless current_restaurant.users.include?(current_user) || current_user.admin
	redirect_to user_path(current_user)
      end
    end
  end

end
