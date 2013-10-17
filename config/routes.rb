Bc140::Application.routes.draw do


  post 'login', to: 'sessions#create', as: 'login'
  post 'logout', to: 'sessions#destroy', as: 'logout'
  post 'signup', to: 'users#create', as: 'signup'

  resource :profile, :except => [:new, :edit]

  resources :tweets, :except => [:new, :edit] do
    get :converse, :on => :member
    get :list, :on => :collection
  end


  post 'follow/:handle' => 'users#follow', :as => 'follow'
  post 'unfollow/:handle' => 'users#unfollow', :as => 'unfollow'
  post 'followers' => 'users#followers', :as => 'followers'
  post 'following' => 'users#following', :as => 'following'

  match '*a', :to => 'errors#routing', :via => [:get, :post]
end
