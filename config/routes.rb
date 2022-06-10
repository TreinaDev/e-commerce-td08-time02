Rails.application.routes.draw do
  devise_for :admins, path: 'admins'
  root 'home#index'

  resources :categories, only: %i[new create]
  resources :pending_admins, only: %i[index] do
    post 'approve', on: :member
  end
end
