Rails.application.routes.draw do

  root 'posts#index'

  get 'about', to: 'static_pages#about'
  get 'help', to: 'static_pages#help'
  get 'contact', to: 'static_pages#contact'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  resources :users do  
     member do
      get :following, :followers
    end
  end

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :posts do
    resources :comments, only:[:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]

  # http://localhost:3000/letter_opener/
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end

end
