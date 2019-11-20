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
    get :data_correction
    get :data_correction_complex
    get :active_runners
  end
  get 'set_lowercase', action: :set_lowercase, controller: 'pages'
  get 'correct_name', action: :correct_name, controller: 'pages'
  get 'auto_correct_name', action: :auto_correct_name, controller: 'pages'

  root to: "pages#home"

end
