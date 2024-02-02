Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters

  root to: 'home#index'

  resources :companies, only: %i[index show new create] do
    post 'link_headhunters', on: :member
  end

  resources :opportunities, only: %i[index show new create] do
    post 'register', on: :member
    post 'close', on: :member
    get 'search', on: :collection
    resources :subscriptions, only: %i[create]
  end

  resources :subscriptions, only: %i[index show update] do
    post 'highlight', on: :member
    resources :proposals, only: %i[new create]
  end

  resources :proposals, only: %i[index show] do
    post 'accept', on: :member
    post 'refuse', on: :member
  end

  resources :profiles do
    resources :experiences, only: %i[create]
    resources :comments, only: %i[create]
  end

  resources :experiences, only: %i[edit destroy]

  defaults format: :json do
    namespace :api do
      namespace :v1 do
        namespace :authentication do
          post '/headhunter', controller: 'sessions', action: 'create'
          post '/candidate', controller: 'sessions', action: 'create'
        end

        get '/ping' => lambda { |env| [200, {}, ['pong']] }

        resources :opportunities, only: %i[index show create update destroy]
        resources :profiles, only: %i[index show create update destroy]
      end
    end
  end
end
