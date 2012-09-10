Tv::Application.routes.draw do

  devise_for :users

  match '/auth/:provider/callback' => 'authentications#create'

  resources :authentications

  resources :my_account, :controller => :my_account
  
  resources :presenters

  resources :events

  resources :videos

  resources :conferences
  
  root :to => 'main#index'
end
