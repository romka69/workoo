Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'tasks#index'

  resources :tasks, except: %i[destroy] do
    resources :bids, shallow: true, only: %i[create destroy]
    resources :comments, shallow: true, only: %i[new create show update]
  end
end
