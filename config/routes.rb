require 'sidekiq/web'

Rails.application.routes.draw do
  resources :books do
    member do
      put "add", to: "books#library"
      put "remove", to: "books#library"
    end
  end
  resources :library, only:[:index]

  devise_for :users, controllers: { registrations: "registrations" }
  root to: 'library#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
