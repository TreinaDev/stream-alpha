Rails.application.routes.draw do
  devise_for :admins
  devise_for :streamers
  devise_for :clients, path: 'clients'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  resources :streamer_profiles, only: %i[show new create]
  resources :client_profiles, only: %i[create new show]
  resources :videos, only: %i[new create show]
end
