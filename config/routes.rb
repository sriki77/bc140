Bc140::Application.routes.draw do
  get 'login', to: 'sessions#create', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  post 'signup', to: 'users#create', as: 'signup'

  resources :sessions, :only => [:create, :destroy]
  resources :users, :only => [:create]
end
