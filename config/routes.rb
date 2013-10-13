Bc140::Application.routes.draw do
  post 'login', to: 'sessions#create', as: 'login'
  post 'logout', to: 'sessions#destroy', as: 'logout'
  post 'signup', to: 'users#create', as: 'signup'

  resources :sessions, :only => [:create, :destroy]
  resources :users, :only => [:create]
  resource :profiles, :except => [:new, :edit]
  resources :tweets, :except => [:new, :edit] do
    member do
      get :converse
    end
  end

  match '*a', :to => 'errors#routing', :via => [:get, :post]
end
