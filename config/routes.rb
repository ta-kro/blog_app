Rails.application.routes.draw do

  root 'posts#home'
  get '/about', to: 'posts#about'
  resources :posts
  
  resources :users, except: [:new, :destroy]
  get '/signup', to: 'users#new'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login'
  post '/logout', to: 'users#logout'
end
