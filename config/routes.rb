Martini::Application.routes.draw do |map|

  match "admin", :to => "admin/overview#index"
  namespace :admin do
    resources :posts, :except => [:show]
    resources :configurations#, :except => [:show]
    resources :pages, :except => [:show]
    resources :tags, :except => [:show]
    resources :categories, :except => [:show]
    resources :assets, :except => [:show]
    resources :quotes, :except => [:show]
    match "configurations/:id" => "configurations#update", :via => :post
  end
  
  match "home", :to => redirect("/")
  resources :posts, :only => [:index, :show]
  resources :tags, :only => [:index, :show]
  resources :categories, :only => [:index, :show]
  resources :pages, :only => [:index, :show]
  
  # users
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'login' => 'user_sessions#new', :as => :login
  match 'authenticate' => 'user_sessions#create', :as => :authenticate, :via => :post
  match 'signup' => 'users#new', :as => :signup
  match 'register' => 'users#create', :as => :register, :via => :post
  match 'connect' => 'users#update', :as => :connect, :via => :put
  
  root :to => "pages#show", :path => "overview"
  
  match '*path/page/:page' => "pages#index"
  match '*path' => "pages#show", :as => :page

end
