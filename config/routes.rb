Rails.application.routes.draw do
  ############################# for Devise
  root to: "events#index"
  devise_for :users
  ############################# Devise over

  resources :users

  resources :events do
    resources :attendances
  ############################# for Stripe
    resources :charges
  ############################# Stripe over

  end

end
