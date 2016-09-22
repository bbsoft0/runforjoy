Rails.application.routes.draw do
  resources :segments
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root to: "segments#index"

 #stats routes should be set manually as stats will not be edited (data import only)
  get '/stats/:id', to: 'stats#show', as: 'stat'
  get '/import/ ', :to => 'stats#import', :as => :import

end
