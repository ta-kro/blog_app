Rails.application.routes.draw do

  root 'posts#home'
  resources :posts
  get '/about', to: 'posts#about'
  resources :users
  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

end
