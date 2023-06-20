Rails.application.routes.draw do
  apipie
  devise_for :users, controllers: {
    registrations: 'registrations',
    sessions: 'sessions',
    passwords: 'passwords'
  }

  devise_scope :user do
    post 'users/sign_up', to: 'registrations#create'
    post 'users/sign_in', to: 'sessions#create'
    delete 'users/sign_out', to: 'sessions#destroy'
    post 'users/password', to: 'passwords#create'
    put 'users/password', to: 'passwords#update'
  end

  resources :reservations
  resources :users
  resources :rooms
  resources :comments
  resources :likes
end
