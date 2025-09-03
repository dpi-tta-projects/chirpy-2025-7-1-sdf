Rails.application.routes.draw do
  root "pages#root"
  get("/", { :controller => "pages", :action => "root" })
  resource :session
  resources :passwords, param: :token
end
