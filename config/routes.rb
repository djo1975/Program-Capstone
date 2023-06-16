Rails.application.routes.draw do
  resources :reservations
  resources :users
  resources :rooms
  resources :comments
  resources :likes
end
