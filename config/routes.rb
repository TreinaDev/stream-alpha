Rails.application.routes.draw do
  devise_for :admins
  devise_for :streamers
  devise_for :clients
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'
  resources :admins, only: %i[] do
    get 'admin_area', on: :collection
  end

  resources :streamer_profiles, only: %i[show new create edit update]
  resources :client_profiles, only: %i[create new show]
  resources :game_categories, only: %i[create new]
  resources :videos, only: %i[new create show]
  resources :game_categories, only: %i[create new]
  resources :plans, only: %i[create new]
end
