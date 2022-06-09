Rails.application.routes.draw do
  devise_for :admins, path: 'admins'
  root 'home#index'

  resources :categories, only: %i[new create index]
end
