Rails.application.routes.draw do

  namespace :categories do
  get 'posts/show'
  end

  resources :categories do
    resources :posts, controller: 'categories/posts'
  end

  root 'categories#index'

end
