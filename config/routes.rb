Rails.application.routes.draw do
  root "pages#landing"

  resources :follows
  resources :chirps
  resource :session
  resources :passwords, param: :token
  resources :users do
    member do
      get "following"
      get "followers"
      get "replies"
      get "likes"
      patch "feed_preference"
    end
  end
end
