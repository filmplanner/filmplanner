require 'sidekiq/web'

Rails.application.routes.draw do
  root to: proc { [404, {}, ["Not found."]] }

  namespace :api do
    resources :days,        only: :index
    resources :movies,      only: :index
    resources :suggestions, only: :index
    resources :theaters,    only: :index
  end

  mount Sidekiq::Web => '/sidekiq'
end
