Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters

  root to: 'home#index'

  resources :opportunities do
    post 'register', on: :member
    post 'close', on: :member
    get 'search', on: :collection
    resources :subscriptions, only: %i[create]
  end

  resources :subscriptions, except: %i[create] do
    post 'highlight', on: :member
    resources :proposals, only: %i[new create]
  end

  resources :proposals, only: %i[index show] do
    post 'accept', on: :member
    post 'refuse', on: :member
  end

  resources :profiles do
    resources :comments, only: %i[create]
  end

  namespace :api do
    namespace :v1 do
      resources :opportunities, only: %i[index show create update destroy]
      resources :profiles, only: %i[index show create update destroy]
    end
  end
end
