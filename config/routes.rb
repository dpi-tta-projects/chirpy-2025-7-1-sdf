Rails.application.routes.draw do
  root "chirps#index"
  resources :chirps
  get("/", { :controller => "pages", :action => "root" })
  resource :session
  resources :passwords, param: :token
end
