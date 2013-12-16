class UserMailer < ActionMailer::Base
  default from: "customer_service@hunger-gains.herokuapp.com"

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
    puts "Sending Approved Restaurant Email"
    mail(to: @user.email, subject: "Your new restaurant, #{@restaurant.name} is ready to take orders!")
    puts "Sent Approved Restaurant Email"
  end

  def pending_restaurant_email(admin, restaurant)
    @admin = admin
    @restaurant = restaurant
    @url = "hunger-gains.herokuapp.com"
    puts "Sending Pendin Restaurant Email"
    mail(to:admin.email, subject: "Restaurant: #{@restaurant.name} is waiting to be approved")
    puts "Sent Pendin Restaurant Email"
  end

  def declined_restaurant_email(user, restaurant)
    @user = user
    @restaurant = restaurant
    @url = "hunger-gains.herokuapp.com"
    puts "Sending Declined Restaurant Email"
    mail(to:user.email, subject: "Restaurant: #{@restaurant.name} has been declined")
    puts "Sent Declined Restaurant Email"
  end
end
