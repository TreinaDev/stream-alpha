Rails.application.routes.draw do
  devise_for :admins
  devise_for :streamers
  devise_for :clients
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'
  resources :admins, only: %i[] do
    get 'admin_area', on: :collection
  end

  resources :client_profiles, only: %i[create new show]

  resources :streamer_profiles, only: %i[show new create edit update index] do
    member do
      post 'inactive'
      post 'active'
    end
  end

  resources :videos, only: %i[new create show approve] do
    get 'analysis', on: :collection
    member do
      post 'approve'
      post 'refuse'
    end
  end

  resources :game_categories, only: %i[create new]
end
