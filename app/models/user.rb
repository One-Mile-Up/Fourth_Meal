class User < ActiveRecord::Base
  authenticates_with_sorcery!
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  has_many :orders
  has_many :roles
  has_many :restaurants, through: :roles

  def associate_order(order_id)
    orders << Order.find(order_id)
  end

  def change_order_to_completed
    orders.last.update_status("completed")
  end

  def recent_orders
    orders.where(status: 'completed')
  end

  def self.admins
    self.where(admin: true)
  end

  def self.declined_restaurant_email(restaurant)
    restaurant.users.each do |user|
      UserMailer.declined_restaurant_email(user, restaurant).deliver
    end
  end

  def self.approved_restaurant_email(restaurant)
    restaurant.users.each do |user|
      UserMailer.new_restaurant_email(user, restaurant).deliver
    end
  end

  def self.pending_resetaurant_email(restaurant)
    User.admins.each do |admin|
      UserMailer.pending_restaurant_email(admin, restaurant).deliver
    end
  end
end
