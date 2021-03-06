Rails.application.routes.draw do
  resources :places
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :stalls do
      resources :reviews, only: [:new, :create, :destroy]
    end

  resources :users, only: [:show]
end
