Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters

  root to: 'home#index'

  resources :opportunities do
    post 'register', on: :member
  end

  resources :profiles do
    get 'verify', on: :member
  end
end
