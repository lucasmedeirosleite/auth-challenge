Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, only: [:sessions], controllers: { sessions: 'sessions' }
end
