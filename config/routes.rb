Tv::Application.routes.draw do

  # omniauth
  match '/auth/:provider/callback' => 'user_sessions#create'
  match '/auth/failure', :to => 'user_sessions#failure'

  # custom logout
  match '/sign_out', :to => 'user_sessions#destroy'

  # application resources
  resources :my_account, :controller => :my_account
  
  resources :presenters

  resources :events

  resources :videos

  resources :conferences
  
  root :to => 'main#index'
end
