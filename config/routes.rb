Rails.application.routes.draw do
  root "pages#landing"

  resources :follows
  resources :chirps do
    collection do
      get "following"
    end
  end
  resource :session
  resources :passwords, param: :token
  resources :users do
    member do
      get "following"
      get "followers"
      get "replies"
      get "likes"
    end
  end
end
