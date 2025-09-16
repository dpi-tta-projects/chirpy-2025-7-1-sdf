Rails.application.routes.draw do
  root "pages#landing"

  resources :chirps
  resource :session
  resources :passwords, param: :token
end
