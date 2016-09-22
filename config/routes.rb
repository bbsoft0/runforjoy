Rails.application.routes.draw do
  resources :stats
  resources :segments
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root to: "segments#index"


end
