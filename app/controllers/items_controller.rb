class ItemsController < ApplicationController

  before_action :require_login, except: [:index, :show, :add_to_order]
  before_action :require_owner, only: [:new, :edit]

  def index
    unless cookies[:order_id]
      order = Order.create
      cookies[:order_id] = order.id
    end

    redirect_to root_path unless current_restaurant.nil? || current_restaurant.approved?

    @categories = Category.all

    if params[:restaurant_slug]
      @items = current_restaurant.items.active
    else
      if params["Categories"]
	@category = Category.find(params["Categories"])
	@items = Item.active.find_all {|item| item.categories.include? @category}
      else
	@items = Item.active
      end
    end

    set_order(cookies[:order_id])
  end

  def destroy
    restaurant = Item.find(params[:id]).restaurant
    Item.destroy(params[:id])
    redirect_to restaurant_path(restaurant)
  end

  def new
    @item = Item.new
    if params[:restaurant_slug]
      @restaurant = Restaurant.find_by(slug: params[:restaurant_slug])
      @categories = Category.where( restaurant: @restaurant)
    else
      @categories = Category.all
    end
  end

  def edit
    @item = Item.find(params[:id])
    @restaurant = @item.restaurant
    if @restaurant
      @categories = Category.where( restaurant: @restaurant)
    else
      @categories = Category.all
    end
  end

  def retire
    @item = Item.find(params[:id])
    @item.active = false
    @item.save

    redirect_to restaurant_dashboard_path(params[:restaurant_slug])
  end

  def create
    @item = Item.new(item_params)
      @item.save
      @item.update_categories(params[:item][:category])
      if @item.restaurant
        redirect_to restaurant_path(@item.restaurant.slug)
      else
        redirect_to root_path
      end
  end

  def show
    @item = Item.find(params[:id])
    set_order(cookies[:order_id])
  end


  def update
    @item = Item.update(params[:id], item_params)
    @item.update_categories(params[:item][:category])
      if @item.restaurant
        redirect_to restaurant_path(@item.restaurant.slug)
      else
      redirect_to root_path
      end
  end

  def add_to_order
    order = Order.find(cookies[:order_id])
    item = Item.find(params[:id])
    if order.items.include? item
      order_item = OrderItem.where(order_id:order.id, item_id:item.id).first
      new_quantity = order_item.quantity + 1
      order_item.update(quantity: new_quantity)
    else
      order.items << item
    end
    flash.notice = item.title + " added to cart!"
    redirect_to :back
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :image, :active, :restaurant_id)
  end

  def set_order(order)
    if order
      @order = Order.find(order)
    else
      @order = nil
    end
  end
end
