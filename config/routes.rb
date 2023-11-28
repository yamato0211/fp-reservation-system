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
    resource :time_slots, controller: 'time_slots'
    resource :time_slot, controller: 'time_slot'
  end

  root 'top#index'
end
