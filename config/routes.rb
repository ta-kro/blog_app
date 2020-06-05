Rails.application.routes.draw do

  root 'static_pages#home'
  get 'about', to: 'static_pages#about'
  get 'help', to: 'static_pages#help'
  get 'contact', to: 'static_pages#contact'

  resources :posts

  resources :users
  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  resources :account_activations, only: [:edit]

  resources :password_resets, only: [:new, :create, :edit, :update]

end
