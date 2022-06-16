Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index create new show] do
      resources :comments, only: [:create]
      resources :likes, only: %i[create destroy]
    end
  end

  root to: 'users#index'
end
