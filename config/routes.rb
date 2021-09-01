Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get 'registration', to: 'users#new'
  post 'registration', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'

  get 'dashboard', to: 'dashboard#index'

  get '/discover', to: 'discover#index'

  resources :movies, only: [:index, :show]

  resources :friendships, only: [:new, :create]

  resources :parties, only: [:new, :create]

  get '/attendees', to: 'attendees#create'
end
