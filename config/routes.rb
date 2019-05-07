Rails.application.routes.draw do
  get 'static_pages/index'
  get 'static_pages/secret'
  ############################# for Devise
  root to: "events#index"



  devise_for :users
  resources :users
  resources :events
  resources :attendances

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
