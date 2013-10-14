Bc140::Application.routes.draw do
  post 'login', to: 'sessions#create', as: 'login'
  post 'logout', to: 'sessions#destroy', as: 'logout'
  post 'signup', to: 'users#create', as: 'signup'

  resources :sessions, :only => [:create, :destroy]
  resources :users, :only => [:create] do
    get :followers, :on => :collection
    get :following, :on => :collection
  end
  resource :profiles, :except => [:new, :edit]
  resources :tweets, :except => [:new, :edit] do
    get :converse, :on => :member
    get :tweets, :on => :collection
  end

  post 'follow/:handle' => 'users#follow', :as => 'follow'
  post 'unfollow/:handle' => 'users#unfollow', :as => 'unfollow'

  match '*a', :to => 'errors#routing', :via => [:get, :post]
end
