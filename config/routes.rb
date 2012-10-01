Tv::Application.routes.draw do

  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/failure', :to => 'user_sessions#failure'

  match '/sign_out', :to => 'user_sessions#destroy'
  
  resources :authentications

  resources :my_account, :controller => :my_account
  
  resources :presenters

  resources :events

  resources :videos

  resources :conferences
  
  root :to => 'main#index'
end
