Rails.application.routes.draw do
  ############################# for Devise
  root to: "home#index"



  devise_for :users
  resources :users
  resources :events
  resources :attendances

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
