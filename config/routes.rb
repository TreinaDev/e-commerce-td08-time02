Rails.application.routes.draw do
  root 'home#index'
  resources :products, only: [:index, :new, :create]
end
