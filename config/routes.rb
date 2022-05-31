Rails.application.routes.draw do
  # get 'home/index'
  root 'home#index'
  get 'users/:user_id/posts'
  get 'users/:user_id/posts/:id'
  get 'users/'
  get 'users/:id'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
