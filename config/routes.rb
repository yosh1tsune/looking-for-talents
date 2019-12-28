Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters

  root to: 'home#index'

  resources :opportunities do
    post 'register', on: :member
    post 'close', on: :member
  end

  resources :candidate_registrations

  resources :profiles do
    post 'highlight', on: :member
  end
end
