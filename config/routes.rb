Rails.application.routes.draw do
  # get 'password_resets/new'
  # get 'password_resets/edit'
  get 'js', to: 'js#index'
  resources :password_resets, only: [:new, :create, :edit, :update]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  # get 'users/new'
  get '/signup', to: 'users#new'
  root 'static_pages#home'
  get '/help', to: 'static_pages#help', as: 'helf'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  resources :microposts, only: [:create, :destroy, :show]
  resources :relationships, only: [:create, :destroy]

  get '/auth/google_oauth2/callback', to: 'sessions#google'
  resources :reacts
end
