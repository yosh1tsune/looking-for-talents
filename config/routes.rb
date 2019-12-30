Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters

  root to: 'home#index'

  resources :opportunities do
    post 'register', on: :member
    post 'close', on: :member
  end

  resources :subscriptions do
    post 'highlight', on: :member
  end

  resources :profiles do
    post 'comment', on: :member
  end

  resources :proposals do
    post 'accept', on: :member
    post 'refuse', on: :member
  end
end
