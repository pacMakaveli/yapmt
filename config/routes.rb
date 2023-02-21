Rails.application.routes.draw do
  resources :changes
  resources :users
  root 'projects#index'

  resources :projects do
    resources :comments
  end
end
