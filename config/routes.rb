Rails.application.routes.draw do
  resources :users
  root to:"home#index"
  resources :blogs
  resources :users
  resources :categories
  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
