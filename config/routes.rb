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
  resources :financial_planners
  resource :time_slots

  # カスタムルートを追加
  delete 'time_slots/destroy_all', to: 'time_slots#destroy_all', as: 'destroy_all_time_slots'

  root 'top#index'
end
