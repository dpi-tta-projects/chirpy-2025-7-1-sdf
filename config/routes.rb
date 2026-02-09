Rails.application.routes.draw do
  root "pages#landing"

  resources :follows
  resources :likes, only: [ :create, :destroy ]
  resources :chirps
  resource :session
  resources :passwords, param: :token
  resources :users do
    member do
      get "following"
      get "followers"
      get "replies"
      get "likes"
      get "digest"
      patch "feed_preference"
    end
  end

  # TODO: restrict to admins
  mount MissionControl::Jobs::Engine, at: "/jobs"
end
