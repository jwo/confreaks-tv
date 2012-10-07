Tv::Application.routes.draw do

  devise_for :users, :controllers => {:sessions => :sessions,
    :registrations => :registrations,
  :omniauth_callbacks => :authentications}

  match '/auth/:provider/callback' => 'authentications#create'

  resources :authentications

  resource :my_account, :controller => :my_account do
    put '/claim_presenter/:id', :on => :member, :action => "claim_presenter"
  end

  
  resources :presenters

  resources :events

  resources :videos

  resources :conferences

  resources :users do
    resources :lists
  end
  
  root :to => 'main#index'
end
