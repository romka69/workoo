Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'tasks#index'

  resources :tasks, except: %i[destroy]
end
