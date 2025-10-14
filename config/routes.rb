Rails.application.routes.draw do
  root "pages#landing"

  # TODO
  # get "follows/followers"
  # get "follows/following"
  resources :follows
  resources :chirps
  resource :session
  resources :passwords, param: :token
  resources :users
end
