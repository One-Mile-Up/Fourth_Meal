class RestaurantsController < ApplicationController
  before_action :require_login
  before_action :require_owner, only: [:show, :update]
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
    User.admins.each do |admin|
      UserMailer.pending_restaurant_email(admin, @restaurant).deliver
    end

    UserMailer.new_restaurant_email(current_user, @restaurant).deliver
    flash.notice = @restaurant.name + " sucessfully created!"

    redirect_to restaurant_path(@restaurant.slug)
  end

  def update
    @restaurant = Restaurant.find_by(slug: params[:restaurant_slug])
    @restaurant.update(status_params)

    if @restaurant.declined?
      @restaurant.users.each do |user|
        UserMailer.declined_restaurant_email(user, @restaurant).deliver
      end
	redirect_to root_path
    else
       redirect_to restaurant_path(@restaurant.slug)
    end
  end


  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :slug)
  end

  def status_params
    params.require(:restaurant).permit(:status)
  end

end
