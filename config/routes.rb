require 'sidekiq/web'

Rails.application.routes.draw do
  root to: proc { [404, {}, ["Not found."]] }

  resources :dates,       only: :index
  resources :movies,      only: :index
  resources :suggestions, only: :index
  resources :theaters,    only: :index

  mount Sidekiq::Web => '/sidekiq'
end
