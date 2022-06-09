Rails.application.routes.draw do
  root 'home#index'

  resources :categories, only: %i[new create]
end
