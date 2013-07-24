Waitlistr::Application.routes.draw do

  root :to => 'home#index'
  resources :users, :only => [:new, :create]
  get "/login" => "session#new", :as => "login"
  post "/login" => "session#create"
  delete "/login" => "session#destroy", :as => "logout"
  get "/home/add" => "home#add"
  get "/home/remove_check" => "home#remove_check"
  get "/home/remove" => "home#remove"
  get "/home/get_user" => "home#get_user"



end
