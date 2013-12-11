DinnerDash::Application.routes.draw do

  resources :items
  resources :orders
  resources :order_items
  resources :users
  resources :categories
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :charges

  root to: 'restaurants#index'

  post "items/add_to_order/:id" => 'items#add_to_order', as: 'add_item'
  get "login" => "user_sessions#new"
  get "logout" => "user_sessions#destroy"

  get "checkout" => "orders#checkout", as: 'checkout'
  post "place_order" => "orders#place_order", as: 'place_order'

  get "dashboard" => "dashboard#show", as: 'dashboard'

  get "/:restaurant_slug", to: "items#index", as: "restaurant"
  put "/:restaurant_slug", to: "restaurants#update"
  get "/:restaurant_slug/dashboard", to: "restaurants#show", as: "restaurant_dashboard"
  get "/:restaurant_slug/items/new", to: "items#new", as: "new_restaurant_item"
  put "/:restaurant_slug/items/new", to: "items#create"
  get "/:restaurant_slug/items/:id/edit", to: "items#edit", as: "edit_restaurant_item"
  put "/:restaurant_slug/items/:id/retire", to: "items#retire", as: "retire_item"
  resources :restaurants

  get "/:restaurant_slug/categories", to: "categories#index", as: "restaurant_item_categories"
  resources :restaurants, :categories
end
