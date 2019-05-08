Rails.application.routes.draw do
  get 'event_space', to: 'static_pages#event_space'
  get 'static_pages/secret'
  ############################# for Devise
  root to: "events#index"



  devise_for :users
  resources :users
  resources :charges
  resources :events do
    resources :attendances
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
