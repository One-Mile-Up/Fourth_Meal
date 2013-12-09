class UserMailer < ActionMailer::Base
  default from: "customer_service@hunger-gains.com"

  def welcome_email(user)
    @user = user
    @url = "hunger-gains.herokuapp.com/login"
    mail(to: @user.email, subject: "Welcome to Platable")
  end

  def order_email(user, order)
    @user = user
    @order = order
    @items = order.items
    @url = "hunger-gains.herokuapp.com"
    mail(to: @user.email, subject: "Your Grub is Forthcoming!")
  end

  def new_restaurant_email(user, restaurant)
    @user = user
    @restaurant = restaurant
    @url = "hunger-gains.herokuapp.com"
    mail(to: @user.email, subject: "Your new restaurant, #{@restaurant.name} is ready to take orders!")
  end
end
