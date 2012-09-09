Tv::Application.routes.draw do

  resources :presenters

  resources :events

  resources :videos

  resources :conferences
  
  root :to => 'main#index'
end
