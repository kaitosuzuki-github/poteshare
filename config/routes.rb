Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'books/confirm'
  resources :books
  get 'rooms/search'
  resources :rooms
  devise_for :users, module: "users"
  devise_scope :user do
    get 'users/account', to: 'users/registrations#account'
    get 'users/profile', to: 'users/registrations#profile'
    get 'users/profile_edit', to: 'users/registrations#profile_edit'
    patch 'users/profile_update', to: 'users/registrations#profile_update'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
