Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'tasks#index'

  resources :tasks, except: %i[destroy] do
    patch :complete, on: :member
    resources :reviews, only: :create
    resources :bids, shallow: true, only: %i[create destroy] do
      patch :approve_executor, on: :member
    end
    resources :comments, shallow: true, only: %i[new create show update]
  end
end
