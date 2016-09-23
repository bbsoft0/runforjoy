Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :segments do
    resources :stats do
      collection { post :import }
    end
  end

  root to: "segments#index"

end
