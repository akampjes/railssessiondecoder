Rails.application.routes.draw do
  resources :decoders
  #root to: 'visitors#index'
  root to: 'decoders#index'
end
