Rails.application.routes.draw do
  resources :reservations
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users
  resources :rooms
  resources :comments
  resources :likes
end
