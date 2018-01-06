Rails.application.routes.draw do
  get 'welcome/index'
  root to: 'blogs#newest'

  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'sessions/new'

  resources :users
  resources :gardenings
  resources :recipes
  resources :pictures
  resources :tags, only: [:create, :destroy]
  resources :blogs

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
