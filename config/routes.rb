Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations]
  devise_for :clients
  devise_for :streamers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'
  resources :admins, only: %i[new create] do
    get 'admin_area', on: :collection
  end

  resources :client_profiles, only: %i[new create show edit update]
  resources :game_categories, only: %i[new create]
  resources :games, only: %i[create new]
  resources :playlists, only: %i[new create show index]
  resources :plans, only: %i[new create show index]

  resources :streamer_profiles, only: %i[new create show index edit update] do
    member do
      post 'inactive'
      post 'active'
    end
  end

  resources :videos, only: %i[new create show update index] do
    get 'analysis', on: :collection
    get 'payment', on: :member
    member do
      post 'approve'
      post 'refuse'
    end
  end
end
