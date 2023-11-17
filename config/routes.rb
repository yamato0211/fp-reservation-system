Rails.application.routes.draw do
  devise_for :financial_planners, controllers: {
    :confirmations => 'financial_planners/confirmations',
    :registrations => 'financial_planners/registrations',
    :sessions => 'financial_planners/sessions',
    :passwords => 'financial_planners/passwords'
  }
  devise_for :users, controllers: {
    :confirmations => 'users/confirmations',
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords'
  }

  resources :users, only: [:index]
  resources :financial_planners, only: [:index]
  resources :signup
  # get '/sign_up', to: 'signup#show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "top#index"
end