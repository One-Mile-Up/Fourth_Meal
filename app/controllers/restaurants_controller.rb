class RestaurantsController < ApplicationController
  before_action :require_login, except: [:show]

  def show
    @restaurant = Restaurant.find_by(slug: params[:restaurant_slug])
    # set_order(cookies[:order_id])
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.save
    flash.notice = @restaurant.name + " sucessfully created!"
    UserMailer.new_restaurant_email(current_user, @restaurant).deliver

    redirect_to restaurant_path(@restaurant.slug)
  end
    
  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :slug)
  end

end
