Rails.application.routes.draw do
  resources :comments
  resources :likes
  resources :posts
  resources :users
  root 'users#index'
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show]
  end
end
