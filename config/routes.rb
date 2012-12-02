Tv::Application.routes.draw do

  get "leader_boards/index"

  match '/auth/:provider/callback' => 'authentications#create'
  
  devise_for :users, :controllers => {:sessions => :sessions,
    :registrations => :registrations,
    :omniauth_callbacks => :authentications}

  resources :authentications

  resource :my_account, :controller => :my_account do
    put '/claim_presenter/:id', :on => :member, :action => "claim_presenter"
  end

  resources :leader_boards, :only => :index
  
  resources :presenters

  resources :events

  resources :videos

  resources :conferences

  resources :users do
    resources :lists
  end

  namespace :admin do
    resources :conferences
    resources :events
    resources :presenters
    resources :users
    resources :videos
  end
  
  root :to => 'main#index'
end
