Rails.application.routes.draw do
  devise_for :admins
  devise_for :streamers
  devise_for :clients
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  resources :streamer_profiles, only: %i[show new create]
end
