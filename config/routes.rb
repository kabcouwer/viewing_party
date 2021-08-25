Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  # resources :users, only: [:new]
  get 'registration', to: 'users#new'
  post 'registration', to: 'users#create'

  get 'login', to: 'users#login'

  get 'dashboard', to: 'users#dashboard'
end
