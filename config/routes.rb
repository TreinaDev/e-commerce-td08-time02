Rails.application.routes.draw do
  devise_for :clients
  devise_for :admins, path: 'admins'
  root 'home#index'

  get 'shopping_cart', to: 'shopping_cart#index'

  resources :categories, only: %i[new create index show]

  resources :products, only: %i[index new create show] do
    resources :product_items, only: %i[create] do
      patch 'sum_quantity', on: :member
      patch 'dec_quantity', on: :member
    end
  end

  resources :pending_admins, only: %i[index] do
    post 'approve', on: :member
  end
end
