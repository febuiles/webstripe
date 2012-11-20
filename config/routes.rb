Ov::Application.routes.draw do
  devise_for :users
  get '/:id' => 'stripes#show', :constraints => {:id => /\d+/}


  resources :stripes
  get "/admin", to: "admin::stripes#index"

  namespace :admin do
    resources :stripes
    resources :users
  end

  root :to => "pages#index"
end
