Rails.application.routes.draw do
  devise_for :admins, path: 'admins'
  root 'home#index'

  resources :categories, only: %i[new create index show]

  resources :products, only: %i[index new create show] do
    post 'activate', on: :member
    post 'deactivate', on: :member
  end

  resources :pending_admins, only: %i[index] do
    post 'approve', on: :member
  end
end
