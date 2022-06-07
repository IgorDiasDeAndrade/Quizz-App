Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  namespace :site do
    get 'welcome/index'
  end
  root to: 'site/welcome#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
