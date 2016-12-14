Rails.application.routes.draw do
  root 'home#index'

  resources :authentication, only: [:new] do
    post :sign_in, on: :collection
  end
end
