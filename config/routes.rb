require 'sidekiq/web'

Rails.application.routes.draw do
  root to: "home#index"

  namespace :api do
    resources :dates,       only: :index
    resources :movies,      only: :index
    resources :shows,       only: :index
    resources :suggestions, only: :index
    resources :theaters,    only: :index
  end

  mount Sidekiq::Web => '/sidekiq'
end
