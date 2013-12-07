class CategoriesController < ApplicationController
  before_action :require_login
  before_action :require_admin

  def index
    @categories = Category.categories_by_slug(params[:restaurant_slug])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Your category was added!"
      redirect_to categories_path
    else
      flash[:error] =  "This category cannot be created!"
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.update(params[:id], category_params)
    redirect_to categories_path
  end

  def show
    @category = Category.find(params[:id])
    # set_order(cookies[:order_id])
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
