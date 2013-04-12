Ov::Application.routes.draw do
  devise_for :users
  get "/bienhecho", to: "stripes#show", :id => 28
  get '/:id' => 'stripes#show', :constraints => {:id => /\d+/}


  resources :stripes
  get "/admin", to: "admin::stripes#index"

  namespace :admin do
    resources :stripes
    resources :stripe_items
    resources :users
  end

  root :to => "pages#index"
  
  match "/terms", :to => "static#terms"
  match "/help", :to => "static#help"
end
