Rails.application.routes.draw do
  root "pages#root"
  resources :chirps
  get("/", { :controller => "pages", :action => "root" })
  resource :session
  resources :passwords, param: :token
end
