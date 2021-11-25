Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations]
  devise_for :streamers
  devise_for :clients
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'
  resources :admins, only: %i[new create] do
    get 'admin_area', on: :collection
  end

  resources :client_profiles, only: %i[create new show edit update]
  resources :game_categories, only: %i[create new]
  resources :games, only: %i[create new]
  resources :plans, only: %i[create new show index]

  resources :streamer_profiles, only: %i[show new create edit update index] do
    member do
      post 'inactive'
      post 'active'
    end
  end

  resources :videos, only: %i[approve create index new show] do
    get 'payment', on: :member
    get 'analysis', on: :collection
    member do
      post 'approve'
      post 'refuse'
    end
  end
end
