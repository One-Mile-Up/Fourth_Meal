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
    User.admins.each do |admin|
      UserMailer.pending_restaurant_email(admin, @restaurant).deliver
    end
    flash.notice = @restaurant.name + " is pending approval."

    redirect_to root_path
  end

  def update

    restaurant = Restaurant.find( params[:id])
    @restaurant =  Restaurant.update(restaurant, status_params)

    if @restaurant.declined?
      @restaurant.users.each do |user|
        UserMailer.declined_restaurant_email(user, @restaurant).deliver
    end
      redirect_to root_path
   elsif @restaurant.approved?
      @restaurant.users.each do |user|
        UserMailer.new_restaurant_email(user, @restaurant).deliver
      end
       redirect_to restaurant_items_path(@restaurant.slug)
    else
       redirect_to restaurant_items_path(@restaurant.slug)
    end
  end


  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :slug)
  end

  def status_params
    params.require(:restaurant).permit(:status)
  end

end
