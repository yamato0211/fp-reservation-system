Rails.application.routes.draw do
  get 'appointments/new'
  get 'time_slot/new'
  devise_for :financial_planners, controllers: {
    confirmations: 'financial_planners/confirmations',
    registrations: 'financial_planners/registrations',
    sessions: 'financial_planners/sessions',
    passwords: 'financial_planners/passwords'
  }
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  resources :users
  resources :financial_planners do
    resource :time_slots, module: :financial_planners
    resources :time_slot, module: :financial_planners
  end

  resources :appointments do
    member do
      patch :regenerate_url
    end
  end

  root 'top#index'
end
