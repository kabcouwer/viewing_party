Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get 'registration', to: 'users#new'
  post 'registration', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'

  get 'dashboard', to: 'dashboard#index'

  get '/discover', to: 'discover#index'
  # if we want to next discover under movies we could use the non-restul route below...
  # get '/discover', to: 'movies#discover'

  # get '/movies', to: 'movies#index'
  resources :movies, only: [:index, :show]
end
