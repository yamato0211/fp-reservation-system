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

  root "top#index"
end