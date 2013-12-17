class RestaurantsController < ApplicationController
  before_action :require_login, except: [:index]
  before_action :require_owner, only: [:show, :update]

  def index
    @restaurants = Restaurant.active
  end

  def show
    @restaurant = Restaurant.find_by(slug: params[:restaurant_slug])
    # set_order(cookies[:order_id])
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.users << current_user
    @restaurant.save

    User.pending_restaurant_email(@restaurant)

    flash.notice = @restaurant.name + " is pending approval."
    redirect_to user_path(current_user)
  end

  def update

    @restaurant = Restaurant.find( params[:id])
    @restaurant.update(status_params)

    if @restaurant.declined?
      User.declined_restaurant_email(@restaurant)

      redirect_to admin_dashboard_path
   elsif @restaurant.approved?
      User.approved_restaurant_email(@restaurant)
      redirect_to admin_dashboard_path
    else
      redirect_to admin_dashboard_path
    end
  end


  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :slug)
  end

  def status_params
    params.require(:restaurant).permit(:status)
  end

end
