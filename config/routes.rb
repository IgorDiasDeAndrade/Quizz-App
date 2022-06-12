Rails.application.routes.draw do
  namespace :site do
    get 'welcome/index'
  end
  namespace :users_backoffice do
    get 'welcome/index'
  end
  namespace :admins_backoffice do
    resources :admins
    resources :subjects
    resources :questions
    get 'welcome/index'
  end
  devise_for :users
  devise_for :admins

  get 'inicio', to: 'site/welcome#index'
  root to: 'site/welcome#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
