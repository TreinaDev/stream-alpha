Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations]
  devise_for :streamers, skip: [:registrations]
  devise_for :clients
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'
  resources :admins, only: %i[new create] do
    collection do
      get 'admin_area'
      get 'admin_contents'
    end
  end

  resources :client_profiles, only: %i[new create show edit update] do
    resources :customer_payment_methods, only: %i[new create show] do
      resources :credit_card_settings, only: %i[new create show]
    end
  end

  resources :game_categories, only: %i[new create index]
  resources :games, only: %i[new create index]
  resources :plans, only: %i[new create show index]
  resources :playlists, only: %i[new create show index]
  resources :streamers, only: %i[new create]

  resources :streamer_profiles, only: %i[new create show index edit update] do
    member do
      post 'inactive'
      post 'active'
    end
  end

  resources :videos, only: %i[new create show index] do
    get 'analysis', on: :collection
    get 'my_videos', on: :collection
    get 'payment', on: :member
    member do
      post 'approve'
      post 'refuse'
    end
  end
end
