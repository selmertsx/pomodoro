Rails.application.routes.draw do
  root to: 'home#index'

  resource :authorization, only: [:new, :create] do
    get :callback, on: :collection
  end

  namespace :api, format: 'json' do
    resources :tasks, only: [:index, :create, :update]
  end

  resources :users
end
