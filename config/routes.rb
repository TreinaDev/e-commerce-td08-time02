Rails.application.routes.draw do
  devise_for :clients
  devise_for :admins, path: 'admins'

  root 'home#index'

  resources :promotions, only: %i[new create index show]
  resources :categories, only: %i[new create index show] do
    post 'activate', on: :member
    post 'deactivate', on: :member
  end
  resources :products, only: %i[index new create show] do
    get 'search', on: :collection
    get 'filter', on: :collection
    post 'activate', on: :member
    post 'deactivate', on: :member
    resources :product_items, only: %i[create destroy] do
      patch 'sum_quantity', on: :member
      patch 'dec_quantity', on: :member
    end
  end
  resources :prices, only: :create

  get 'shopping_cart', to: 'shopping_cart#index'

  resources :pending_admins, only: %i[index] do
    post 'approve', on: :member
  end
end
