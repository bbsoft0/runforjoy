Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :segments do
    resources :stats do
      collection { post :import }
      collection { get :graph }
    end
  end

  controller :pages do
    get :about
    get :home
  end

  root to: "pages#home"

end
