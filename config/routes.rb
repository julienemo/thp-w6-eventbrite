Rails.application.routes.draw do
  ############################# for Devise
  root to: "events#index"
  devise_for :users
  ############################# Devise over

  resources :users

  resources :events do
    resources :attendances
    resources :charges
  end
  
end
