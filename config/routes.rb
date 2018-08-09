Rails.application.routes.draw do
  root to: 'home#index'

  resource :authorization, only: [:new, :create]

  namespace :api, format: 'json' do
    resources :tasks, only: [:index, :create, :update]
  end
end
