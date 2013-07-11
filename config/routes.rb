Waitlistr::Application.routes.draw do

  root :to => 'home#index'
  resources :user, :only => [:new, :create]
  get "/login" => "session#new", :as => "login"
  post "/login" => "session#create"
  delete "/login" => "session#destroy", :as => "logout"
  get "/home/add" => "home#add"

end
