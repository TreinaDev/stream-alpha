Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations]
  devise_for :clients
  devise_for :streamers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'
  resources :admins, only: %i[new create] do
    collection do
      get 'admin_area'
      get 'admin_contents'
    end
  end

  resources :clients, only: %i[] do
    get 'my_payment_methods', on: :member
  end
  resources :client_profiles, only: %i[new create show edit update]
  resources :game_categories, only: %i[new create index]
  resources :games, only: %i[new create index]
  resources :playlists, only: %i[new create show index]
  resources :plans, only: %i[new create show index]

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
