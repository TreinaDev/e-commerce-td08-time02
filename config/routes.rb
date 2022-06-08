Rails.application.routes.draw do
  devise_for :admins, path: 'admins'
  root 'home#index'
end
